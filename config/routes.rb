Rails.application.routes.draw do
  root 'application#hello'
  get 'static_pages/home'
end
