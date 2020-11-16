class AddDevelopmentalEditingQuoteToSampleDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    add_column :sample_developmental_edits, :developmental_editing_quote, :integer
  end
end
