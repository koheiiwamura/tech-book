class RenameStreetAddressColumnToOrderDetails < ActiveRecord::Migration
  def change
    rename_column :order_details, :street_adress, :street_address
  end
end
