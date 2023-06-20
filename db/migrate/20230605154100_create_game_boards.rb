class CreateGameBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :game_boards do |t|

      t.timestamps
    end
  end
end
