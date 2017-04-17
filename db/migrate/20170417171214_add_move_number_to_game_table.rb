class AddMoveNumberToGameTable < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :move_number, :integer
  end
end
