class AddEmailToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :email, :string
  end
end
