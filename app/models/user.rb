class User < ActiveRecord::Base
  include Role::Behaviour

  has_secure_password
  has_many :scrapnotes, dependent: :destroy

  validates :username, presence: true, uniqueness: true
end
