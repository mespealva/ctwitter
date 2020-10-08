class User < ApplicationRecord
  after_destroy { |record| Friend.where(friend_id: :id).delete_all}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friends, dependent: :destroy        
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy 
  has_many :liked_tweets, :through => :likes, :source => :tweet 
         
  validates_presence_of :name, message: 'debe contener algo' 
  validates_uniqueness_of :name, message: 'nombre ya tomado'

  def users_followed
    arr_ids = self.friends.pluck(:friend_id)
    arr_ids = arr_ids.reject {|f| !User.all.ids.include?(f)}
    User.find(arr_ids)
  end

  def is_following?(user)
    users_followed.include?(user)
  end

  def friends_count
    friend = self.friends
    friends = friend.reject {|f| !User.all.ids.include?(f.friend_id)}
    friends.count
  end 
    
  def tweets_count
    self.tweets.where(rt: nil).count
  end 
    
  def likes_given
    self.likes.count
  end 
  
  def retweets_given
    self.tweets.where.not(rt: nil).count
  end 

  def busca(id)
    User.find(id)
  end
end