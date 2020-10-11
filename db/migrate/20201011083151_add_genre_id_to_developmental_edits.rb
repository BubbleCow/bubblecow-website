class AddGenreIdToDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    add_column :developmental_edits, :genre_id, :integer
  end
end
