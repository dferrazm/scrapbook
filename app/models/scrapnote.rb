class Scrapnote < ActiveRecord::Base
  belongs_to :user
  belongs_to :mood

  validates :user, :content, presence: true
end
