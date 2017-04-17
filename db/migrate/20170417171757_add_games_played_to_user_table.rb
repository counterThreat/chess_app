class AddGamesPlayedToUserTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :games_played, :integer
  end
end
