class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :type
      t.string :color
      t.integer :x_position
      t.integer :y_position
      t.integer :game_id
      t.integer :user_id
      t.boolean :moved
      t.boolean :captured

      t.timestamps
    end
  end
end
