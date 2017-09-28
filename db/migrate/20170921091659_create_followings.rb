class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|

    	t.references :leader
    	t.references :follower
    end

# followings is the table you want to add the foreign key to
# users is the table you want to reference to, which is why it is not user (a single column)
# column are the column name we want to add. The fields should reference to the users table, so it should contain only user_id.
    add_foreign_key :followings, :users, column: :leader_id, primary_key: :id
    add_foreign_key :followings, :users, column: :follower_id, primary_key: :id


    
  end
end
