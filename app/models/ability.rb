# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(game_board)
    game_board ||= GameBoard.new
    can :manage, GameBoard, id: game_board.id
    can :manage, Turn, game_board: game_board
  end
end
