Rails.application.routes.draw do
  # Root
  root 'static_pages#home'

  # Static
  get  '/contact', to: 'static_pages#contact'
  get  '/tos', to: 'static_pages#terms', as: 'terms'

  # Devise
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  devise_scope :user do
    get "users/edit_password", to: 'users/registrations#edit_password', as: 'edit_password'
    put 'users/edit_password', to: 'users/registrations#update_password', as: 'update_password'
  end

  # Resources
  resources :users, only: [:show, :index] do
    member do
      get :following, :followers
      get :get_works_owned
      get :get_works_liked
      get :get_works_stocked
    end
  end

  resources :works do
    resources :likes, only: [:create, :destroy]
    collection do
      get 'get_category_children', defaults: { fomat: 'json' }
      get 'search', to: 'works#search'
    end
  end

  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :notifications, only: :index

  get 'tags/:title', to: 'tags#show', as: :tag

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
