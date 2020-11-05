class CreateGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :genres do |t|
      t.string :type
      t.string :slug

      t.timestamps
    end
    add_index :genres, :slug, unique: true
  end
end
