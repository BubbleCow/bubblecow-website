class AddAasmStateToDevEditSamples < ActiveRecord::Migration[7.0]
  def change
    add_column :dev_edit_samples, :aasm_state, :string
  end
end
