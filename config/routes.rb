Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static#home'

  resources :sessions, only: [:new, :create]

  resources :appointments, only: [:index, :new, :create, :edit, :update]

  resources :patients, only: [:new, :create, :edit, :update] do
    resources :appointments, only: :index
  end

  resources :doctors, only: :show do
    resources :appointments, only: :index
  end

  # resources :patients, only: [:new, :create, :show, :edit, :update] do
  #   resources :appointments, only: [:new, :create, :edit, :update]
  # end

  # resources :patients, only: [:new, :edit] do
  #   resources :appointments, only: [:show, :new, :create, :edit, :update]
  # end

end
