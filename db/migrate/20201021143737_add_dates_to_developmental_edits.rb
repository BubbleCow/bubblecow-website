class AddDatesToDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    add_column :developmental_edits, :invoice_paid_date, :datetime
    add_column :developmental_edits, :developmental_edit_due_date, :datetime
  end
end
