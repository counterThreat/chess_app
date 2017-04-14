class UpdateMovedInPieces < ActiveRecord::Migration[5.0]
  def change
    change_column :pieces, :moved, :boolean, default: false
  end
end
