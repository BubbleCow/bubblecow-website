class AddSeoTitleToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :seo_title, :string
  end
end
