class AddUnicodeToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :unicode, :string
  end
end
