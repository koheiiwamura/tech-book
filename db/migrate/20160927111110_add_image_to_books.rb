class AddImageToBooks < ActiveRecord::Migration
  def self.up
    change_column :book, :price, :integer, :null => false, :default => 0
    change_column :book, :postage, :integer, :null => false, :default => 0
  end
 
  def self.down
    change_column :book, :price, :integer, :null => false
    change_column :book, :postage, :integer, :null => false
  end
end
