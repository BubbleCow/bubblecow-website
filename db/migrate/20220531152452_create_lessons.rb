class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.string :slug
      t.text :content
      t.integer :course_id

      t.timestamps
    end
    add_index :lessons, :slug, unique: true
  end
end
