class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :avatar, :string
  	add_column :users, :username, :string
   	add_column :users, :dob, :date
 	add_column :users, :gender, :string
  end
end
