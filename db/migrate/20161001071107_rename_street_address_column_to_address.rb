class RenameStreetAddressColumnToAddress < ActiveRecord::Migration
  def change
    rename_column :addresses, :street_adress, :street_address
  end
end
