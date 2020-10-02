class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friends, dependent: :delete_all        
  has_many :tweets, dependent: :delete_all 
  has_many :likes, dependent: :delete_all 
  has_many :liked_tweets, :through => :likes, :source => :tweet 
         
  validates_presence_of :name, message: 'debe contener algo' 
  validates_uniqueness_of :name, message: 'nombre ya tomado'

  def users_followed
    arr_ids = self.friends.pluck(:friend_id)
    User.find(arr_ids)
  end

  def is_following?(user)
    users_followed.include?(user)
  end

  def friends_count
    self.friends.count
  end 
    
  def tweets_count
    self.tweets.where(rt: nil).count
  end 
    
  def likes_give_it
    self.likes.count
  end 
  
  def retweets_give_it
    self.tweets.where.not(rt: nil).count
  end 
end
