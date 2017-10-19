class Picture < ActiveRecord::Base
    validates :content, presence: true
    belongs_to :picture
end
