class Scrapnote < ActiveRecord::Base
  belongs_to :user
  belongs_to :humour

  validates :user, :content, presence: true
end
