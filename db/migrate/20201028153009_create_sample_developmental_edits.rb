class CreateSampleDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    create_table :sample_developmental_edits do |t|
      t.string :title
      t.integer :user_id
      t.string :slug
      t.integer :word_count
      t.string :language
      t.string :genre_id
      t.string :aasm_state
      t.string :editor_id

      t.timestamps
    end
    add_index :sample_developmental_edits, :slug, unique: true
  end
end
