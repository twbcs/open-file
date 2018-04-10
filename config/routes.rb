Rails.application.routes.draw do
  root 'authors#index'
  resources :authors do
    get :remove, on: :member
    get :search, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
