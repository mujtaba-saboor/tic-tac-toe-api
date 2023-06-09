# frozen_string_literal: true

class Turn < ApplicationRecord
  belongs_to :game_board

  validate :game_not_completed
  validates_presence_of :tile_type, :tile_position
  validates :tile_type, inclusion: { in: 1..2 }
  validates :tile_position, inclusion: { in: 1..9 }

  validates_uniqueness_of :tile_position, scope: %i[tile_position game_board_id]

  TURN_BY = { x: 1, o: 2 }.freeze
  WINNING_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ].freeze

  attr_accessor :post_result

  after_create :check_result

  def game_not_completed
    raise ApiExceptionModule::GameCompleted, I18n.t(:game_completed) if game_board.completed?
  end

  def check_result
    result = { winner: nil, tie: false }
    turns = game_board.turns

    return result if turns.size < 5

    x_turns = turns.where(tile_type: Turn::TURN_BY[:x]).pluck(:tile_position)
    o_turns = turns.where(tile_type: Turn::TURN_BY[:o]).pluck(:tile_position)

    result[:winner], result[:winner_tiles] = find_winner(x_turns, o_turns)
    result[:tie] = result[:winner].nil? && turns.size == 9

    if result[:winner] || result[:tie]
      game_board.update(completed: true)
      won_by = result[:winner] || 'tie'
      game_board.winners.create!(won_by: won_by)
      result[:winner_count] = game_board.winner_count
    end

    self.post_result = result
  end

  def find_winner(x_turns, o_turns)
    WINNING_COMBINATIONS.each do |winning_combination|
      return ['O', winning_combination] if (winning_combination - o_turns).empty?
      return ['X', winning_combination] if (winning_combination - x_turns).empty?

    end
    []
  end
end
