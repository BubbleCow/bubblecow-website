class AddAhoyToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :ahoy_visit_id, :bigint
  end
end
