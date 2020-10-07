class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liking_users, :through => :likes, :source => :user
    validates :content, presence: true
    validates :content, length: {minimum:4, maximum:280}
    paginates_per 50

    scope :nuevos, -> {order("created_at DESC") } 

    scope :tweets_for_me, -> (user) { where(user_id: user.friends.pluck(:friend_id).push(user.id)) }
    
    scope :fifty, ->  {order("created_at DESC").last(50)}
    
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

      def ret
        Tweet.where(rt: self.id)
      end

      def self.search(search)
        if search
          find_by(content: ['content LIKE ?', "%#{search}%"])
        else
          @tweets = Tweet.paginate(page: params[:page], per_page: 50).nuevos
        end
      end
      
      def has_hashtag?
        self.content.include?("#")
      end

      def separar
        array = []
        #new_array=[]
        array = self.content.split(" ")
        #array.each do |h| 
        #    if h.start_with?('#') 
        #     h=h.gsub('#', '')
          # #   h = "<%=link_to '#{h}', search_path(#{h})%>" 
        #    else
        #      h
        #    end
        #  new_array.push(h)
        #end 
        #return new_array
        return array
      end
      
      def buscar(busca)
        Tweet.find(busca)
      end
end
