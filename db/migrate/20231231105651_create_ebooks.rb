class CreateEbooks < ActiveRecord::Migration[7.1]
  def change
    create_table :ebooks do |t|
      t.string :title
      t.text :description
      t.string :version
      t.string :slug

      t.timestamps
    end
    add_index :ebooks, :slug, unique: true
  end
end
