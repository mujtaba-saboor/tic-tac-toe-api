# frozen_string_literal: true

# tracks turn serializer
class TurnSerializer < ActiveModel::Serializer
  attributes :prev_turn, :next_turn, :winner, :winning_tiles, :winner_count, :tie

  def prev_turn
    Turn::TURN_BY.key(object.tile_type).upcase
  end

  def next_turn
    object.tile_type == 1 ? 'O' : 'X'
  end

  def winner
    game_result[:winner]
  end

  def winning_tiles
    game_result[:winning_tiles]
  end

  def winner_count
    game_result[:winner_count]
  end

  def tie
    game_result[:tie]
  end

  def game_result
    object.game_stats || {}
  end
end
