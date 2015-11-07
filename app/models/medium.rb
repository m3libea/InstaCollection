class Medium < ActiveRecord::Base
    has_many :tag_media
    has_many :tag_feed, through: :tag_media
end
