Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#home'

  get  '/auth/facebook/callback' => 'sessions#create' 
  get  '/login'          => 'sessions#new'
  get  '/signup'         => 'patients#new'
  post '/login'          => 'sessions#create'
  get  '/logout'         => 'sessions#destroy'
  get  '/conditions/:id' => 'conditions#destroy'
  get  '/drugs/:id'      => 'drugs#destroy'
  get  '/home'           => 'doctors#show'

  resources :doctors, only: [] do
    resources :appointments, only: [:index, :new, :create]
  end

  resources :patients, only: [:index, :show, :new, :create, :edit, :update] do
    resources :appointments, only: [:index, :show, :edit, :update, :destroy]
  end

end
