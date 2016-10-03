class RemoveBuyerIdFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :buyer_id, :integer
  end
end
