# frozen_string_literal: true

# ApiRequestAuthenticate contains authentication of API token
class ApiRequestAuthenticate
  def initialize(game_board_id)
    @game_board_id = game_board_id
  end

  def authenticate
    JsonApiToken.encode_token(game_board_id: current_game_board.id)
  end

  private

  attr_reader :game_board_id

  def current_game_board
    GameBoard.find_by(id: game_board_id)
  end
end
