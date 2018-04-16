Rails.application.routes.draw do
  root 'authors#index'
  resources :animes do
    get :search, on: :collection
    get :run, on: :member
  end

  resources :authors do
    get :search, on: :collection
    get :run, on: :member
  end

  resources :movies do
    get :search, on: :collection
    get :run, on: :member
  end

  namespace :manager do
    resources :animes do
      get :remove, on: :member
      get :search, on: :collection
    end

    resources :authors do
      get :remove, on: :member
      get :search, on: :collection
      resources :archives, only: [:edit, :update, :create, :new] do
        get :rating, on: :member
      end
    end

    resources :movies do
      get :remove, on: :member
      get :search, on: :collection
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
