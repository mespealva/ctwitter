class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :liking_users, :through => :likes, :source => :user
    validates :content, presence: true
    validates :content, length: {minimum:4, maximum:280}

    scope :nuevos, -> {order("created_at DESC") } 

    def is_liked?(user)
        if self.liking_users.include?(user)
          true
        else
          false 
        end 
      end 
    
      def remove_like(user)
        Like.where(user: user, tweet: self).first.destroy
      end
    
      def add_like(user)
        Like.create(user: user, tweet: self)
      end 
    
      def count_rt
        Tweet.where(rt: self.id).count
      end
end
