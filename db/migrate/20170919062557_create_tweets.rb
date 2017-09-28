class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|

    	t.text :post

    	t.references :user, foreign_key: true
    	t.timestamps

    end
  end
end
