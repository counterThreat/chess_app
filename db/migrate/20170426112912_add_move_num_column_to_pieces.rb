class AddMoveNumColumnToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :move_num, :integer
  end
end
