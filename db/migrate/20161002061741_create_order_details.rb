class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.string :first_name
      t.string :last_name
      t.text :street_adress
      t.string :postal_code
      t.string :phone_number
      t.timestamps null: false

      t.timestamps null: false
    end
  end
end
