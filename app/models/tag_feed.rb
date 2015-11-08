class TagFeed < ActiveRecord::Base
    has_many :tag_media
    has_many :media, through: :tag_media, dependent: :destroy
    def default_values
        self.initial_tag_id ||= nil
        self.latest_tag_id ||= nil
        self.is_complete ||= false
    end
end
