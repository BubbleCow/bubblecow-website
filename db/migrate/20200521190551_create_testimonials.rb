class CreateTestimonials < ActiveRecord::Migration[6.0]
  def change
    create_table :testimonials do |t|
      t.string :writer
      t.string :slug
      t.boolean :approved, default: false

      t.timestamps
    end
    add_index :testimonials, :slug, unique: true
  end
end
