class ModifyOrders < ActiveRecord::Migration[7.0]
  def change
    # Additions
    add_column :orders, :product_id, :bigint, null: false
    add_column :orders, :aasm_state, :string
    add_column :orders, :editor_id, :bigint
    add_column :orders, :invoice_sent_at, :datetime
    add_column :orders, :invoice_paid_at, :datetime
    add_column :orders, :product_due_date, :datetime
    add_column :orders, :product_returned_on, :date

    add_index :orders, :editor_id, name: "index_orders_on_editor_id"
    add_index :orders, :product_id, name: "index_orders_on_product_id"

    # Removals
    remove_column :orders, :user_id
    remove_column :orders, :order_number
    remove_column :orders, :status
  end
end
