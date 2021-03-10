Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  root 'static_pages#home'
  get  '/contact', to: 'static_pages#contact'
  resources :users, only: [:show]
end
