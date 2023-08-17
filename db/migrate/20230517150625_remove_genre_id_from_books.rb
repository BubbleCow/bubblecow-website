class RemoveGenreIdFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :genre_id
  end
end
