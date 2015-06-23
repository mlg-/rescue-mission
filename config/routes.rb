Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users
  resources :questions, only: [:index, :show, :new, :create]
end
