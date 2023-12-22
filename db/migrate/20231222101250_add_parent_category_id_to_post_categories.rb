class AddParentCategoryIdToPostCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :post_categories, :parent_category_id, :integer
    add_foreign_key :post_categories, :post_categories, column: :parent_category_id
  end
end
