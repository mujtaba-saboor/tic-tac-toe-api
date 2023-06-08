# frozen_string_literal: true

# ApiRequestAuthorize contains authentication of API token
class ApiRequestAuthorize
  def initialize(request = {})
    @cookies = request.cookies
    @headers = request.headers
  end

  def authorize
    { game_board: current_game_board }
  end

  private

  attr_reader :headers, :cookies

  def current_game_board
    @current_game_board ||= GameBoard.find_by(id: decoded_game_board_id)
  end

  def jwt_decoded_token
    token = headers['HTTP_TOKEN'].presence || cookies['CSRF-TOKEN'].presence
    @jwt_decoded_token ||= JsonApiToken.decode_token(token)
  end

  def decoded_game_board_id
    return if headers['HTTP_TOKEN'].blank? && cookies['CSRF-TOKEN'].blank?

    jwt_decoded_token[:game_board_id]
  end
end
