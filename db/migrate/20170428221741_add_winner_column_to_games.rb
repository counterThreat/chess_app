class AddWinnerColumnToGames < ActiveRecord::Migration[5.0]
  def change
    add_reference :games, :winner, index: true
    add_foreign_key :games, :users, column: 'winning_player_id'
  end
end
