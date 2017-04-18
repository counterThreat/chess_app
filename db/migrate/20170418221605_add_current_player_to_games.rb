class AddCurrentPlayerToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :current_player, :integer
  end
end
