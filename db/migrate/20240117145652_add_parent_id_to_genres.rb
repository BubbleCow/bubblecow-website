class AddParentIdToGenres < ActiveRecord::Migration[7.1]
  def change
    add_column :genres, :parent_id, :integer
    add_index :genres, :parent_id
  end
end
