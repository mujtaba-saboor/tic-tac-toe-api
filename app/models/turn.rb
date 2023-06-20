# frozen_string_literal: true

class Turn < ApplicationRecord
  belongs_to :game_board

  validates_presence_of :tile_type, :tile_position
  validates :tile_type, inclusion: { in: 1..2 }
  validates :tile_position, inclusion: { in: 1..9 }
  validates_uniqueness_of :tile_position, scope: %i[tile_position game_board_id]
  validate :check_turn_validity

  after_create :find_game_stats

  attr_accessor :game_stats

  TURN_BY = { x: 1, o: 2 }.freeze

  WINNING_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ].freeze

  def check_turn_validity
    return if (last_turn = game_board.turns.last).blank? || (last_turn.tile_type != tile_type)

    errors.add(:base, 'Tile not supported')
  end

  def find_game_stats
    current_turns = game_board.turns

    self.game_stats = if current_turns.size < 5
                        { winner: nil, tie: false }
                      else
                        extract_winner_or_tie(current_turns)
                      end
  end

  def extract_winner_or_tie(current_turns)
    player_x_tile_positions = current_turns.where(tile_type: Turn::TURN_BY[:x]).pluck(:tile_position)
    player_o_tile_positions = current_turns.where(tile_type: Turn::TURN_BY[:o]).pluck(:tile_position)

    winner, winning_tiles = find_winner(player_x_tile_positions, player_o_tile_positions)
    tie = winner.nil? && current_turns.size == 9
    mark_game_board_completed(winner) if winner || tie
    winner_count = game_board.winner_count

    { tie: tie,
      winner: winner,
      winning_tiles: winning_tiles,
      winner_count: winner_count }
  end

  def find_winner(player_x_tile_positions, player_o_tile_positions)
    WINNING_COMBINATIONS.each do |winning_combination|
      return ['O', winning_combination] if (winning_combination - player_o_tile_positions).empty?
      return ['X', winning_combination] if (winning_combination - player_x_tile_positions).empty?
    end
    []
  end

  def mark_game_board_completed(winner)
    game_board.update(completed: true)
    won_by = winner || 'tie'
    game_board.winners.create!(won_by: won_by)
  end
end
