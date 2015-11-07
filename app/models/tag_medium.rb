class TagMedium < ActiveRecord::Base
    belongs_to :tag_feed
    belongs_to :medium
end
