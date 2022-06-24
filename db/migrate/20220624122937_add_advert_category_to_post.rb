class AddAdvertCategoryToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :advert_category, :string
  end
end
