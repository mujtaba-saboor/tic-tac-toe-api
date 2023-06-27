# frozen_string_literal: true

# ApplicationController gets called before each controller
class ApplicationController < ActionController::API
  include ApiExceptionModule
  include ApiResponse
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  before_action :authorize_api_request
  after_action :set_csrf_cookie
  attr_reader :current_game_board
  alias current_user current_game_board

  private

  def authorize_api_request
    response = ApiRequestAuthorize.new(request).authorize
    @current_game_board = response[:game_board]
  end

  def set_csrf_cookie
    if cookies['CSRF-TOKEN'].present? && JSON.parse(response.body)['game_board_auth_token'].present? && (cookies['CSRF-TOKEN'] != JSON.parse(response.body)['game_board_auth_token'])
      cookie_value = JSON.parse(response.body)['game_board_auth_token']
    else
      cookie_value = cookies['CSRF-TOKEN'].presence || JSON.parse(response.body).dig('game_board', 'auth_token')
    end
    cookies['CSRF-TOKEN'] = {
      value: cookie_value,
      domain: :all
    }
  end
end
