class AddBuyerIdToBook < ActiveRecord::Migration
  def change
    add_column :books, :buyer_id, :integer
  end
end
