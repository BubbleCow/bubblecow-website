class AddPenNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pen_name, :string
  end
end
