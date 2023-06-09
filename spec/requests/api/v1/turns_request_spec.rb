# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Turns', type: :request do
  describe 'Create turn' do
    before :each do
      game_board = GameBoard.create!
      @id = game_board.id
      cookies['CSRF-TOKEN'] = valid_token_generator(@id)
    end

    context 'create' do
      it 'creates turn' do
        params = { tile_type: 'o', tile_position: 5 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        expect(parse_json['prev_turn']).to eq('O')
        expect(parse_json['next_turn']).to eq('X')
      end

      it 'creates turn - game completed' do
        params = { tile_type: 'x', tile_position: 1 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        params = { tile_type: 'o', tile_position: 2 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        params = { tile_type: 'x', tile_position: 4 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        params = { tile_type: 'o', tile_position: 3 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        params = { tile_type: 'x', tile_position: 7 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        expect(parse_json['prev_turn']).to eq('X')
        expect(parse_json['next_turn']).to eq('O')
        expect(parse_json['winner']).to eq('X')
        expect(parse_json['winner_tiles']).to eq([1, 4, 7])
        expect(parse_json['winner_count']['X']).to eq(1)
      end

      it 'fails creation - position repeat' do
        params = { tile_type: 'o', tile_position: 5 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        post "/api/v1/game_boards/#{@id}/turns", params: params
        expect(parse_json['error_message']).to eq('Validation failed: Tile position has already been taken')
      end

      it 'fails creation - game completed' do
        params = { tile_type: 'o', tile_position: 5 }
        GameBoard.find(@id).update!(completed: true)
        post "/api/v1/game_boards/#{@id}/turns", params: params
        expect(parse_json['game_completed']).to eq(true)
        expect(parse_json['error_message']).to eq('Game Already Completed')
      end

      it 'fails creation - position out of bound' do
        params = { tile_type: 'o', tile_position: 51 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        expect(parse_json['error_message']).to eq('Validation failed: Tile position is not included in the list')
      end

      it 'fails creation - tile not valid' do
        params = { tile_type: 'k', tile_position: 5 }
        post "/api/v1/game_boards/#{@id}/turns", params: params
        expect(parse_json['error_message']).to eq('Tile not supported')
      end
    end
  end

  describe 'Index turn' do
    before :each do
      game_board = GameBoard.create!
      @id = game_board.id
      cookies['CSRF-TOKEN'] = valid_token_generator(@id)
    end
    context 'index' do
      it 'returns turns' do
        get "/api/v1/game_boards/#{@id}/turns"
        expect(parse_json.key?('turns')).to eq(true)
      end
    end
  end
end
