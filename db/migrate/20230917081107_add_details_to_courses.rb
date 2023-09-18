class AddDetailsToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :description_short, :text
    add_column :courses, :access_level, :integer, default: 0
  end
end
