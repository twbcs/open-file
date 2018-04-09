Rails.application.routes.draw do
  root 'authors#index'
  resources :authors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
