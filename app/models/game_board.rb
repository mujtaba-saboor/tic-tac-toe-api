# frozen_string_literal: true

class GameBoard < ApplicationRecord
  has_many :turns, dependent: :destroy
  has_many :winners, dependent: :destroy

  WINNING_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [3, 5, 7]
  ].freeze

  after_create :create_token
  attr_accessor :auth_token

  def reset
    turns.destroy_all
    update!(completed: false)
  end

  def create_token
    self.auth_token = ApiRequestAuthenticate.new(id).authenticate
  end

  def winner_count
    winners.group(:won_by).count
  end
end
