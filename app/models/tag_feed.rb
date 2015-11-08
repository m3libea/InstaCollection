class TagFeed < ActiveRecord::Base
    has_many :tag_media
    has_many :media, through: :tag_media, dependent: :destroy

    def default_values
        self.initial_tag_id ||= nil
        self.latest_tag_id ||= nil
        self.is_complete ||= false
    end
    def parse_date
        unless start_date_string.blank?
          self.start_date = DateTime.parse(start_date)
        end

        unless end_date_string.blank?
          self.end_date = DateTime.parse(end_date)
        end
    end
end
