class Mood < ActiveRecord::Base
  validates :description, presence: true
end
