class AddCompletedToGameBoard < ActiveRecord::Migration[6.1]
  def change
    add_column :game_boards, :completed, :boolean
  end
end
