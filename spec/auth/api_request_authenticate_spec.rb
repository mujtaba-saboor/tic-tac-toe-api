# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiRequestAuthenticate do
  before :all do
    @test_game_board = build(:game_board)
    @test_game_board.save
    @valid_request = ApiRequestAuthenticate.new(@test_game_board.id)
  end

  describe 'Valid Authorize Api Request' do
    context 'valid request' do
      it 'should return a game_board token' do
        response = @valid_request.authenticate
        game_board_id = JsonApiToken.decode_token(response)[:game_board_id]
        expect(game_board_id).to eq(@test_game_board.id)
      end
    end
  end
end
