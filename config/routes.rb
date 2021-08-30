Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :profile, only: %i(index update) do
    get :edit, on: :collection
  end
  resources :users, only: :show
  resources :posts, only: :show
  
  namespace :admin do
    resources :posts, only: %i(index new create edit update)
    resources :posts_preview, only: %i(index create update)
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
