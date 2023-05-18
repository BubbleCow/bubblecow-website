class DropGenresTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :genres
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
