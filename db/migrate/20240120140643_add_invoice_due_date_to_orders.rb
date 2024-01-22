class AddInvoiceDueDateToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :invoice_due_date, :date
  end
end
