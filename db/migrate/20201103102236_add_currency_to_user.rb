class AddCurrencyToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :currency, :string
  end
end
