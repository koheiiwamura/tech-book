class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :content
      t.string :state
      t.integer :price
      t.integer :postage
      t.integer :likes_count, default: 0
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
