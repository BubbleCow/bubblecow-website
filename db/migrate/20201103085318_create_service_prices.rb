class CreateServicePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :service_prices do |t|
      t.string :service_type
      t.string :currency
      t.integer :price

      t.timestamps
    end
  end
end
