# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    resource :session, only: %i[destroy]
    resources :repositories, only: %i[index show new create]
  end
  mount Sidekiq::Web => '/sidekiq'
end
