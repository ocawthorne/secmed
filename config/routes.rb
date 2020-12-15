Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:new, :create]

  # get '/login', to: 'sessions#new'

  resources :doctors, only: [:show] do
    resources :appointments, only: [:index, :show]
  end

  resources :patients, only: [:show] do
    resources :appointments, only: [:index, :show, :new, :create, :edit, :update]
  end

end
