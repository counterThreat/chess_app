class UpdateColumnInPieces < ActiveRecord::Migration[5.0]
  def change
    change_column :pieces, :captured, :boolean, :default => false
  end
end
