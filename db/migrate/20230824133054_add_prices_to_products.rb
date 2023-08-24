class AddPricesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price_usd, :decimal, precision: 8, scale: 2
    add_column :products, :price_gbp, :decimal, precision: 8, scale: 2
    add_column :products, :price_eur, :decimal, precision: 8, scale: 2
  end
end
