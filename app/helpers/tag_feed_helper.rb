module TagFeedHelper

    #Helper method, called by controller when a post petition comes to the API
    def self.create_tag(tf)
        client_id = ENV["client_id"]

        tagName = tf.hashtag

        url = "https://api.instagram.com/v1/tags/" + tagName +"/media/recent"
        uri = URI(url)
        params = {:client_id => client_id}
        uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(uri)

        json = JSON.parse(res.body)

        process_json(tf,json)    
    end

    #Helper method, called by scheduler on Heroku to update the tag_feed
    def self.update_tag(tf)
        client_id = ENV["client_id"]

        tagName = tf.hashtag

        url = "https://api.instagram.com/v1/tags/" + tagName +"/media/recent"

        uri = URI(url)
        params = {:client_id => client_id, :max_tag_id => tf.latest_tag_id}
        uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(uri)

        json = JSON.parse(res.body)

        process_json(tf,json)        
    end

    #Helper method to process a json given the Tag Feed an json
    def self.process_json(tf, json)
        puts "Adding new content.."
        counter_added = 0
        counter_updated = 0

        json["data"].each do |media|

            flag = true

            #Check if hashtag is in comment instead the caption
            if(!media["caption"]["text"].downcase.include?(tf.hashtag.downcase)) 
                media["comments"]["data"].each do |c|

                    comment_date = Time.at(c["created_time"].to_i).getutc
                    comment_user = c["from"]["username"]
                    comment_text = c["text"]

                    on_date = comment_date <= tf.end_date && comment_date >= tf.start_date

                    #Check if in the comment, user of the comment is the picture author, and date include in range

                    if(!(comment_text.include?(tf.hashtag) && comment_user == media["user"]["username"] && on_date))
                        flag = false
                        break
                    end    
                end
            end

            if(flag)    
                created_time = Time.at(media["created_time"].to_i).getutc

                if(created_time >= tf.start_date && created_time <= tf.end_date)

                    id = media["caption"]["id"] 

                    m = Medium.exists?(:tag_id => id)
                    if(m)
                        med = Medium.find_by(:tag_id => id)
                        med.update_attributes(:data => media.to_json)
                        if(!tf.media.exists?(:tag_id => id))
                            tf.media << med
                        end    
                        counter_updated+=1
                    else
                        new_media = Medium.create(data: media.to_json, tag_id: id, creation_date: Time.at(created_time))
                        tf.media << new_media
                        counter_added+=1
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
        puts "Created: " + counter_added.to_s + " Updated: " + counter_updated.to_s    
    end
 
end
