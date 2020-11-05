class AddEditReturnDateToDevelopmentalEdit < ActiveRecord::Migration[6.0]
  def change
    add_column :developmental_edits, :edit_return_date, :datetime
  end
end
