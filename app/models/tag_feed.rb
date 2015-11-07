class TagFeed < ActiveRecord::Base
    has_many :tag_media
    has_many :media, through: :tag_media, dependent: :destroy
end
