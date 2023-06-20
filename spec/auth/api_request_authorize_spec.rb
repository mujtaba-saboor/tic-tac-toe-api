# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiRequestAuthorize do
  before :all do
    @test_game_board = build(:game_board)
    @test_game_board.save
  end

  before :each do
    cookie = { 'CSRF-TOKEN' => valid_token_generator(@test_game_board.id) }
    allow_any_instance_of(ActionDispatch::Request).to receive(:cookies).and_return(cookie)
  end

  describe 'Valid Authorize Api Request' do
    context 'valid request' do
      it 'should return a game_board object' do
        @request = ApiRequestAuthorize.new(ActionDispatch::Request.new({}))
        response = @request.authorize
        expect(response[:game_board]).to eq(@test_game_board)
      end
    end
  end

  describe 'Invalid Authorize Api Request' do
    context 'api token present but expired' do
      before :each do
        cookie = { 'CSRF-TOKEN' => expired_token_generator(@test_game_board.id) }
        allow_any_instance_of(ActionDispatch::Request).to receive(:cookies).and_return(cookie)
      end

      it 'gives nil game_board' do
        @request = ApiRequestAuthorize.new(ActionDispatch::Request.new({}))
        expect(@request.authorize).to eq({ game_board: nil })
      end
    end

    context 'api token present but for invalid game_board' do
      before :each do
        cookie = { 'CSRF-TOKEN' => expired_token_generator(123) }
        allow_any_instance_of(ActionDispatch::Request).to receive(:cookies).and_return(cookie)
      end

      it 'gives nil game_board' do
        @request = ApiRequestAuthorize.new(ActionDispatch::Request.new({}))
        expect(@request.authorize).to eq({ game_board: nil })
      end
    end

    context 'api token present but invalid' do
      before :each do
        cookie = { 'CSRF-TOKEN' => 'Random_invalid_token' }
        allow_any_instance_of(ActionDispatch::Request).to receive(:cookies).and_return(cookie)
      end

      it 'gives nil game_board' do
        @request = ApiRequestAuthorize.new(ActionDispatch::Request.new({}))
        expect(@request.authorize).to eq({ game_board: nil })
      end
    end
  end
end
