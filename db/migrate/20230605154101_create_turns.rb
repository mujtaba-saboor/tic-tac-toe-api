class CreateTurns < ActiveRecord::Migration[6.1]
  def change
    create_table :turns do |t|
      t.references :game_board, foreign_key: true
      t.integer :tile_type
      t.integer :tile_position

      t.timestamps
    end
  end
end
