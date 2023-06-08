# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :game_boards, only: %i[create] do
        member do
          delete 'reset'
        end

        resources :turns, only: %i[create index]
      end
    end
  end
  # mount ActionCable.server => 'api/v1/gameboard'

  match '/*path', controller: 'api/v1/errors', action: 'error_four_zero_four', via: :all
  root to: 'api/v1/errors#error_four_zero_four', via: :all
end
