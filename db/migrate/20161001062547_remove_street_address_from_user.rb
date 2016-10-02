class RemoveStreetAddressFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :street_adress, :text
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :postal_code, :string
    remove_column :users, :phone_number, :string
  end
end
