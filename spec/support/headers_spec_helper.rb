# frozen_string_literal: true

module HeadersSpecHelper
  def expired_token_generator(game_board_id)
    JsonApiToken.encode_token({ game_board_id: game_board_id }, (Time.now.to_i - 14))
  end

  def valid_token_generator(game_board_id)
    JsonApiToken.encode_token(game_board_id: game_board_id)
  end
end
