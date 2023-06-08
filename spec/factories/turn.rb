# frozen_string_literal: true

FactoryBot.define do
  factory :turn do
    game_board { GameBoard.new }
  end
end
