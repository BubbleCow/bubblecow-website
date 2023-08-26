class AddNewPricesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price_aud, :decimal, precision: 8, scale: 2
    add_column :products, :price_nzd, :decimal, precision: 8, scale: 2
    add_column :products, :price_cad, :decimal, precision: 8, scale: 2
  end
end
