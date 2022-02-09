class AddSourceToMessage < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :source, :string
  end
end
