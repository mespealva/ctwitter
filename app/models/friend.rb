class Friend < ApplicationRecord
    belongs_to :user

    def self.amigos(id)
        self.where(user_id: id) 
    end
end
