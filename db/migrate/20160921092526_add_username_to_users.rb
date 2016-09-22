class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :username, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :postal_code, :string
    add_column :users, :street_adress, :text
  end
end
