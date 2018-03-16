Rails.application.routes.draw do


  root to: 'posts#index'

  get '/admin' => 'admin/sessions#new'

  get '/login' => 'admin/sessions#index'
  get '/logout' => 'admin/sessions#destroy'

  namespace :admin do

    resources :dashboard, only: [:index]
    resources :settings, only: [:new, :create, :edit, :update]
    resources :categories
    resources :posts do
      resources :sections
    end
    resources :tags, except: [:index]
    resources :galleries
    resources :images, only: [:index, :edit, :update, :destroy]
    resources :links
    resources :sessions, only: [:index, :create, :destroy]
    resources :moderators, only: [:index, :edit, :update]
    resources :uploads, only: [:create, :destroy]

  end

  resources :posts, only: [:index, :show]


end
