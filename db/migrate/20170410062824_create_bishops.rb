class CreateBishops < ActiveRecord::Migration[5.0]
  def change
    create_table :bishops do |t|

      t.timestamps
    end
  end
end
