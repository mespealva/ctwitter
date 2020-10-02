class AddReferanceToLike < ActiveRecord::Migration[5.2]
  def change
    add_reference :likes, :user, foreign_key: true
    add_reference :likes, :tweet, foreign_key: true
  end
end
