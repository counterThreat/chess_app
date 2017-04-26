class AddColumnToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :move_num, :integer, default: 0
  end
end
