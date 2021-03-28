Rails.application.routes.draw do
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
  root 'static_pages#home'
  get  '/contact', to: 'static_pages#contact'
  get  '/tos', to: 'static_pages#terms', as: 'terms'
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end
  resources :works do
    resources :likes, only: [:create, :destroy]
  end
  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
