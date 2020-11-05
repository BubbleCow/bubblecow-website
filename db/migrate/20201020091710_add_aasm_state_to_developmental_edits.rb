class AddAasmStateToDevelopmentalEdits < ActiveRecord::Migration[6.0]
  def change
    add_column :developmental_edits, :aasm_state, :string
  end
end
