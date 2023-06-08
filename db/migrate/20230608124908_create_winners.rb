class CreateWinners < ActiveRecord::Migration[6.1]
  def change
    create_table :winners do |t|
      t.references :game_board, foreign_key: true
      t.string :won_by

      t.timestamps
    end
  end
end
