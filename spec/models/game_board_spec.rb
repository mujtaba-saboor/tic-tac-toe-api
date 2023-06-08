# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameBoard, type: :model do
  it 'should remove turns if game_board is destroyed' do
    game_board = create(:game_board)
    game_board_id = game_board.id
    game_board.turns.create!(tile_type: 1, tile_position: 1)
    game_board.winners.create!(won_by: 'x')
    game_board.destroy
    expect(Turn.find_by(game_board_id: game_board_id)).to eql(nil)
    expect(Winner.find_by(game_board_id: game_board_id)).to eql(nil)
  end
end
