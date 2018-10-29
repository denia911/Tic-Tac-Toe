class CreateMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
