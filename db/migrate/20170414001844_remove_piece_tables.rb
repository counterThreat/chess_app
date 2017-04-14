class RemovePieceTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :kings
    drop_table :queens
    drop_table :bishops
    drop_table :rooks
    drop_table :pawns
    drop_table :knights
  end
end
