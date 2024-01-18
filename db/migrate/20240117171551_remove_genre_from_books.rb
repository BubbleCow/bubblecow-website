class RemoveGenreFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :genre, :string
  end
end
