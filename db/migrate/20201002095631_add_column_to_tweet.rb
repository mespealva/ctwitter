class AddColumnToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :rt, :integer
  end
end
