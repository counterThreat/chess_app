class AddLastMoveToPieceTable < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :last_move, :integer
  end
end
