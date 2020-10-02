class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :content, limit: 280

      t.timestamps
    end
  end
end
