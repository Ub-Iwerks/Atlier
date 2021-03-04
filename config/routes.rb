Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    # :omniauth_callbacks => 'users/registrations',
    :passwords => 'users/passwords',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
   }
  root 'static_pages#home'
  get  '/help', to: 'static_pages#help'
end
