class AddDefaultToPlayerTurn < ActiveRecord::Migration[5.0]
  def change
    change_column :games, :player_turn, :string, default: 'white'
  end
end
