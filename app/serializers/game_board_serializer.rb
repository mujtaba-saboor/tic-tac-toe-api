# frozen_string_literal: true

# tracks game_board serializer
class GameBoardSerializer < ActiveModel::Serializer
  attributes :id, :completed, :auth_token, :turns, :winner_count

  def current_game_board
    object
  end

  def game_board_auth_token
    object.auth_token
  end

  def turns
    (1..9).map { |idx| { tile_position: idx } }
  end
end
