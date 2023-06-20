# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::GameBoards', type: :request do
  describe 'Create game board' do
    context 'create' do
      it 'creates game board' do
        post '/api/v1/game_boards'
        expect(parse_json.key?('game_board')).to eq(true)
        expect(parse_json['game_board'].key?('turns')).to eq(true)
        expect(parse_json['game_board'].key?('id')).to eq(true)
        expect(parse_json['game_board'].key?('auth_token')).to eq(true)
      end
    end
  end

  describe 'Reset game board' do
    context 'reset' do
      before :each do
        game_board = GameBoard.create!(completed: true)
        @id = game_board.id
        cookies['CSRF-TOKEN'] = valid_token_generator(@id)
      end

      it 'reset game board' do
        delete "/api/v1/game_boards/#{@id}/reset"
        expect(parse_json['reset']).to eq(true)
        expect(GameBoard.find_by(id: @id).completed).to eq(false)
      end
    end
  end
end
