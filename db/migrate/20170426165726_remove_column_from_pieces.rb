class RemoveColumnFromPieces < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :move_num, :integer
  end
end
