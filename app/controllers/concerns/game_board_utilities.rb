# frozen_string_literal: true

# GameBoardUtilities
module GameBoardUtilities
  extend ActiveSupport::Concern

  # if a game-board exists against the current cookie then we use it,
  # else we create a new gameboard. This is added to avoid redundant
  # game board creation for same cookie.
  def find_or_create_game_board
    if (game_board = current_game_board).present?
      game_board.turns.destroy_all
    else
      game_board = GameBoard.create!
    end
    @game_board = game_board
  end
end
