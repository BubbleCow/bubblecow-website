class RenameTitleToNameInProducts < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :title, :name
  end
end
