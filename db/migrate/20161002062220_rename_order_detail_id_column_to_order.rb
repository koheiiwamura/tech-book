class RenameOrderDetailIdColumnToOrder < ActiveRecord::Migration
  def change
    rename_column :orders, :voucher_id, :order_detail_id
  end
end
