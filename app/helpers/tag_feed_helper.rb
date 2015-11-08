module TagFeedHelper

    def self.update_tag(tf)
        client_id = ENV["client_id"]


        tagName = tf.hashtag

        url = "https://api.instagram.com/v1/tags/" + tagName +"/media/recent"

        uri = URI(url)
        params = {:client_id => client_id}
        uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(uri)

        json = JSON.parse(res.body)

        json["data"].each do |media|
            flag = true

            #Check if hashtag is on comments, and the comment is from the picture author
            if(!media["caption"]["text"].downcase.include?(tf.hashtag.downcase)) 
                puts media["caption"]["text"]     
                puts tf.hashtag
                media["comments"].each do |c|
                    if(!(c["data"]["text"].include?(tf.hashtag) && c["data"]["from"]["username"] == media["user"]["username"]))
                        flag = false
                        break
                    end    
                end
            end


            if(flag)
                created_time = Time.at(media["created_time"].to_i).getutc

                if(created_time >= tf.start_date && created_time <= tf.end_date)

                    id = media["id"].split("_")[0] 

                    m = Medium.exists?(:tag_id => id)
                    if(m)
                        @med = Medium.find_by(:tag_id => id)
                        @med.update_attributes(:data => media.to_json)
                    else
                        new_media = Medium.create(data: media.to_json, tag_id: id, creation_date: Time.at(created_time))
                        tf.media << new_media 
                    end
                end   

                if(created_time > tf.end_date)
                    tf.is_complete = true
                end 
            end 
        end

        if(tf.media.count != 0)
            tf.initial_tag_id = tf.media.first.tag_id
            tf.latest_tag_id = tf.media.last.tag_id
        end
        tf.save
    end

    
end
