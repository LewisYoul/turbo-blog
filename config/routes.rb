Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :profile, only: %i(index update) do
    get :edit, on: :collection
  end
  resources :users, only: :show
  resources :posts, only: :show
  resources :search do
    get :index, on: :collection
    post :index, on: :collection
  end
  
  namespace :admin do
    resources :post_tags, only: %i(create destroy)
    resources :tags, only: %i(index new create destroy)
    resources :posts, only: %i(index new create edit update destroy)
    resources :preview do
      post :index, on: :collection
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
