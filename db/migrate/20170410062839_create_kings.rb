class CreateKings < ActiveRecord::Migration[5.0]
  def change
    create_table :kings do |t|

      t.timestamps
    end
  end
end
