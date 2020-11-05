class AddThingsToDevelopmentalEdit < ActiveRecord::Migration[6.0]
  def change
    add_column :developmental_edits, :word_count, :integer
    add_column :developmental_edits, :language, :string
  end
end
