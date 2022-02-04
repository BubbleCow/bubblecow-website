class AddAasmStateToDevEdits < ActiveRecord::Migration[7.0]
  def change
    add_column :dev_edits, :aasm_state, :string
  end
end
