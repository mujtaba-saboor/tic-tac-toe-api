# frozen_string_literal: true

class JsonApiToken
  PRIVATE_SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.decode_token(game_board_token)
    HashWithIndifferentAccess.new(JWT.decode(game_board_token, PRIVATE_SECRET_KEY)[0])
  rescue JWT::DecodeError
    nil
  end

  def self.encode_token(game_board_payload, expiry = nil)
    expiry ||= 24.hours.from_now
    game_board_payload[:exp] = expiry.to_i
    JWT.encode(game_board_payload, PRIVATE_SECRET_KEY)
  end
end
