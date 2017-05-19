class AddWinCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :wins, :integer, default: 0
    add_index :users, :wins
  end
end
