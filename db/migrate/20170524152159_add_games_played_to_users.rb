class AddGamesPlayedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :games_played, :integer, default: 0
  end
end
