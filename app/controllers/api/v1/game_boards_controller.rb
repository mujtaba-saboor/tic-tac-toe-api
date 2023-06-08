# frozen_string_literal: true

# GameBoardsController gets called for fetching current game board
class Api::V1::GameBoardsController < ApplicationController
  def create
    response = find_or_create_game_board

    format_json_response(response)
  end

  def reset
    current_game_board.reset

    format_json_response(reset: true)
  end

  private

  def find_or_create_game_board
    response = {}
    if (game_board = current_game_board).nil?
      game_board = GameBoard.create!
      game_board_token = ApiRequestAuthenticate.new(game_board.id).authenticate
      response[:game_board_auth_token] = game_board_token
    end
    game_board.turns.destroy_all
    add_data_to_response(game_board, response)

    response
  end

  def add_data_to_response(game_board, response)
    response[:current_game_board] = game_board
    response[:turns] = game_board.turns_data
    response[:winner_count] = game_board.winner_count
  end
end
