class FixGenreColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :genres, :type, :genre_type
  end
end
