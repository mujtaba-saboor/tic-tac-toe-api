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

  private

  def authorize_api_request
    response = ApiRequestAuthorize.new(request).authorize
    @current_game_board = response[:game_board]
  end

  def set_csrf_cookie
    cookies['CSRF-TOKEN'] = {
      value: cookies['CSRF-TOKEN'].presence || JSON.parse(response.body)['game_board_auth_token'],
      domain: :all
    }
  end
end
