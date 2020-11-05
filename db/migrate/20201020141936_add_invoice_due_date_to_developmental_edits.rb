class AddInvoiceDueDateToDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    add_column :developmental_edits, :invoice_due_date, :datetime
  end
end
