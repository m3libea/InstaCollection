desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
    require 'net/http'
    require 'json'


    tag_feeds = TagFeed.where(:is_complete => false).where("start_date <= ?", Time.now)

    tag_feeds.each do |tf| 
        TagFeedHelper::update_tag(tf)
    end
end
 
