Rails.application.routes.draw do
  root 'welcome#index'
  
  # user
  devise_for :users
  
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search_friend'
  
  # stocks
  get 'search_stock', to: 'stocks#search'

  # user + stock relantion
  resources :user_stocks, only: [:create, :destroy]
end
