class AddActagToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :ac_tag, :string
  end
end
