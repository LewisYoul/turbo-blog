Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  resources :profile, only: %i(index update) do
    get :edit, on: :collection
  end
  resources :users, only: :show
  resources :posts, only: :show
  
  namespace :admin do
    resources :posts, only: %i(index new create)
    resources :posts_preview, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
