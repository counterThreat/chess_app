class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rating, :integer, default: 1500
    add_index :users, :rating
  end
end
