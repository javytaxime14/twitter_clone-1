class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user
  validates :content, presence: true
  has_and_belongs_to_many :tags 

  paginates_per 50

  scope :tweets_for_me, -> (user) { where(user_id: user.arr_friends_id) }

  def is_liked?(user)
    self.liking_users.include?(user)
  end

  def like(user)
    Like.create(user: user, tweet: self)
  end

  def unlike(user)
    Like.where(user: user, tweet: self).destroy_all
  end

  def rt_count
    Tweet.where(rt_ref: self.id).count
  end

  def is_retweet?
    self.rt_ref.present?
  end

  def tweet_ref
    Tweet.find(self.rt_ref)
  end

  after_create do
    hashtags = self.content.scan(/#\w+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      self.tags << tag
    end
  end

  before_update do
    self.tags.clear
    hashtags = self.content.scan(/#\w+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
      self.tags << tag
    end
  end




end
