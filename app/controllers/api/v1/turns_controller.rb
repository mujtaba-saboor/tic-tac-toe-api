# frozen_string_literal: true

# TurnsController gets called for turns in a game
class Api::V1::TurnsController < ApplicationController
  load_and_authorize_resource :game_board
  load_and_authorize_resource :turn, through: :game_board

  def index
    format_json_response(@turns)
  end

  def create
    @turn.save!
    format_json_response(@turn)
  end

  private

  def turn_params
    params[:tile_type] = Turn::TURN_BY[params[:tile_type]&.downcase&.to_sym] unless params[:tile_type].is_a?(Integer)
    params.permit(:tile_type, :tile_position)
  end
end
