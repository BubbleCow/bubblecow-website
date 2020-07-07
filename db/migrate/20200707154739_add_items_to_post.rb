class AddItemsToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :name, :string
    add_column :posts, :permalink, :string
    add_column :posts, :keywords, :string
  end
end
