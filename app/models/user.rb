class User < ActiveRecord::Base
  has_many :scrapnotes, dependent: :destroy

  validates :name, presence: true
end
