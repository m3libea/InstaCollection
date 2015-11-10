require 'net/http'
module TagFeedHelper

    @api_url_base = "https://api.instagram.com/v1/tags/"
    @max_requests = ENV["max_tag_requests"].to_i

    def self.api_call(tag_name, params)
        puts "[API] tag[" + tag_name + "] call with " + params.to_s

        url = URI(@api_url_base + tag_name +"/media/recent")
        url.query = URI.encode_www_form(params)

        return Net::HTTP.get_response(url)
    end

    #Helper method, called by controller when a post petition comes to the API
    def self.create_tag(tf)
        res = api_call(tf.hashtag, {:client_id => ENV["client_id"]});

        json = JSON.parse(res.body)

        process_json(tf,json)

        tf.initial_tag_id = json["pagination"]["next_max_tag_id"]
        tf.latest_tag_id = json["pagination"]["min_tag_id"]

        tf.save
    end

    #Helper method, called by scheduler on Heroku to update the tag_feed
    def self.update_tag(tf)
        puts "[Update Tag] Starting tag [" + tf.hashtag + "] update"
        request_count = 0
        min_tag_id = 0
        next_max_tag_id = nil
        
        loop do 
            puts "[Update Tag] tag [" + tf.hashtag + "] request " + request_count.to_s

            res = api_call(tf.hashtag, {:client_id => ENV["client_id"], :max_tag_id => next_max_tag_id})
            request_count += 1
            json = JSON.parse(res.body)
            
            min_tag_id = [json["pagination"]["min_tag_id"].to_i, min_tag_id.to_i].max()
            next_max_tag_id = json["pagination"]["next_max_tag_id"].to_i
            
            process_json(tf,json)            
            
            break if (tf.is_complete || 
                tf.latest_tag_id.to_i > next_max_tag_id || 
                request_count > @max_requests)            
        end

        tf.latest_tag_id = min_tag_id

        tf.save
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

                if(tf.start_date == nil && tf.enddate == nil)
                    break
                elsif(tf.end_date == nil)
                    tf.end_date = tf.start_date
                elsif(tf.start_date == nil)
                    tf.start_date = tf.end_date
                else    

                    if(created_time >= tf.start_date || created_time <= tf.end_date)

                        id = media["caption"]["id"] 

                        #Check if Media already exist on the db and update or add
                        m = Medium.exists?(:tag_id => id)
                        if(m)
                            med = Medium.find_by(:tag_id => id)
                            med.update_attributes(:data => media.to_json) 
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
        end

        tf.save
        puts "Created: " + counter_added.to_s + " Updated: " + counter_updated.to_s    
    end
 
end
