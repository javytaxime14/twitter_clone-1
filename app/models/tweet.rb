class Tweet < ApplicationRecord
  belongs_to :user
  has_many :liking_users, :through => :likes, :source => :user
end
