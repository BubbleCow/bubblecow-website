class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :user_id
      t.string :language
      t.integer :genre_id
      t.integer :word_count
      t.string :slug

      t.timestamps
    end
    add_index :books, :slug, unique: true
  end
end
