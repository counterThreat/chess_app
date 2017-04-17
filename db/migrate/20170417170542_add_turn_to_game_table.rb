class AddTurnToGameTable < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :turn, :string
  end
end
