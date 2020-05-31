class CreateDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    create_table :developmental_edits do |t|
      t.string :title
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    add_index :developmental_edits, :slug, unique: true
  end
end
