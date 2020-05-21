class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.integer :post_category_id
      t.integer :post_author_id
      t.boolean :published, default: false
      t.datetime :published_at

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end
