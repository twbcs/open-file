Rails.application.routes.draw do
  root 'authors#index'
  resources :authors do
    get :search, on: :collection
  end

  namespace :manager do
    resources :authors do
      get :remove, on: :member
      get :search, on: :collection
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
