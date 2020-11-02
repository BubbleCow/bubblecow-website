class AddSampleEditReturnDateToSampleDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    add_column :sample_developmental_edits, :sample_edit_return_date, :datetime
  end
end
