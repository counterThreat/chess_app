class AddIndexToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :player_id, :integer
  end
end
