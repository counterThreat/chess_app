class CreateRooks < ActiveRecord::Migration[5.0]
  def change
    create_table :rooks do |t|

      t.timestamps
    end
  end
end
