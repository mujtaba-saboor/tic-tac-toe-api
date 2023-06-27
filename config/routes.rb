# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :game_boards, only: %i[create show] do
        member do
          delete 'reset'
        end

        resources :turns, only: %i[create index]
      end
    end
  end

  match '/*path', controller: 'api/v1/errors', action: 'error_four_zero_four', via: :all
  root to: 'api/v1/errors#error_four_zero_four', via: :all
end
