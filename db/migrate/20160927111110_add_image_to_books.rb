class AddImageToBooks < ActiveRecord::Migration
  def self.up
    change_column :books, :price, :integer, :null => false, :default => 0
    change_column :books, :postage, :integer, :null => false, :default => 0
  end
 
  def self.down
    change_column :books, :price, :integer, :null => false
    change_column :books, :postage, :integer, :null => false
  end
end
