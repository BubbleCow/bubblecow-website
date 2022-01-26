class AddStatusValueToDevEditSamples < ActiveRecord::Migration[7.0]
  def change
    add_column :dev_edit_samples, :status_value, :integer, default: 1
  end
end
