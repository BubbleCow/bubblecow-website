class AddGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.string :genre_type
      t.string :slug
      
      t.timestamps
    end

    add_index :genres, :slug, unique: true
  end
end
