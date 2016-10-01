class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.text :street_adress
      t.string :postal_code
      t.string :phone_number
      t.timestamps null: false
    end
  end
end
