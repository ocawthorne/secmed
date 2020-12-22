Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#home'

  get  '/login' => 'sessions#new'
  get '/auth/facebook/callback' => 'sessions#create' 
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/conditions/:id' => 'conditions#destroy'
  get '/drugs/:id' => 'drugs#destroy'

  get '/home' => 'doctors#show'

  resources :doctors, only: [] do
    resources :appointments, only: [:index, :new, :create]
  end

  resources :patients, only: [:index, :show, :new, :create, :edit, :update] do
    resources :appointments, only: [:index, :show, :edit, :update]
  end

  # resources :patients, only: [:new, :create, :edit, :update] do
  #   resources :appointments, only: [:show, :index]
  # end

  # resources :appointments, only: [:new, :create] do
  #   resources :doctors, only: :index
  #   resources :patients, only: [:index, :edit, :update, :show]
  # end
  
  # resources :patients, only: [:new, :create, :edit, :update, :show]

  # resources :doctors, only: :show do
  #   resources :appointments, only: :index
  # end

  # resources :sessions

  # resources :patients, only: [:new, :create, :show, :edit, :update] do
  #   resources :appointments, only: [:new, :create, :edit, :update]
  # end

  # resources :patients, only: [:new, :edit] do
  #   resources :appointments, only: [:show, :new, :create, :edit, :update]
  # end

end
