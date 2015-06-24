Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users
  resources :questions
  resources :answers, only: [:new, :create, :index, :show]
end
