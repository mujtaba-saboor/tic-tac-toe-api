# frozen_string_literal: true

# GameBoardsController gets called for fetching current game board
class Api::V1::GameBoardsController < ApplicationController
  include GameBoardUtilities

  before_action :find_or_create_game_board, only: :create
  load_and_authorize_resource :game_board, except: :create

  def create
    format_json_response(@game_board)
  end

  def show
    format_json_response(@game_board)
  end

  def reset
    @game_board.reset
    format_json_response(reset: true)
  end
end
