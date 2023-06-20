# frozen_string_literal: true

# TurnsController gets called for turns in a game
class Api::V1::TurnsController < ApplicationController
  before_action :check_if_game_active

  def index
    format_json_response(turns: current_game_board.turns)
  end

  def create
    response = {}
    turn = current_game_board.turns.create!(format_params)

    response[:prev_turn] = Turn::TURN_BY.key(turn.tile_type).upcase
    response[:next_turn] = turn.tile_type == 1 ? 'O' : 'X'
    if turn.post_result.present?
      response[:winner] = turn.post_result[:winner]
      response[:winner_tiles] = turn.post_result[:winner_tiles]
      response[:winner_count] = turn.post_result[:winner_count]
      response[:tie] = turn.post_result[:tie]
    end

    format_json_response(response)
  end

  private

  def turn_params
    params.permit(:tile_type, :tile_position)
  end

  def check_if_game_active
    raise ActiveRecord::RecordNotFound, 'Game Board Not Present' if current_game_board.nil?
  end

  def format_params
    formatted = turn_params
    formatted[:tile_type] = Turn::TURN_BY[turn_params[:tile_type]&.downcase&.to_sym]
    raise ApiExceptionModule::InvalidTile, 'Tile not supported' if formatted[:tile_type].blank?

    formatted
  end
end
