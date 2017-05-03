class AddDetailsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :outcome, :string
    add_column :games, :finished, :datetime
  end
end
