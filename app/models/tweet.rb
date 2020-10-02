class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :liking_users, :through => :likes, :source => :user
    validates :content, presence: true
    validates :content, length: {minimum:4, maximum:280}

    scope :nuevos, -> {order("created_at DESC") } 

    scope :tweets_for_me, -> (user) { where(user_id: user.friends.pluck(:friend_id).push(user.id)) }

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

      def self.search(search)
        if search
          find_by(content: ['content LIKE ?', "%#{search}%"])
        else
          @tweets = Tweet.paginate(page: params[:page], per_page: 50).nuevos
        end
      end
      
       def has_hashtag?
         self.content.split(" ").each do |word|
           if word.include?("#")
             return true
           else
             return false
           end
          end
        end

      def add_hashtags
        array = []
        array = self.content.split(" ")
        array= array.map { |hashtag| hashtag.start_with?('#') ? ("<%=link_to(#{hashtag}, root_path+'?search='+#{hashtag})%>").html_safe : hashtag }
        self.content = array.join(" ")
      end
end
