# frozen_string_literal: true

class Winner < ApplicationRecord
  belongs_to :game_board

  after_create :destroy_old_turns

  def destroy_old_turns
    game_board.turns.destroy_all
  end

end
