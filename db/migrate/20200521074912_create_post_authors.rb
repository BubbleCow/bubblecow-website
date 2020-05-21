class CreatePostAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :post_authors do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :post_authors, :slug, unique: true
  end
end
