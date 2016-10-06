class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :bank_name
      t.string :branch_name
      t.string :account_type
      t.integer :number
      t.string :holder_name
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
