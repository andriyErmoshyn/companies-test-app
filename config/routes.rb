Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :companies, only: %i[index create update destroy] do
        resources :branches, only: %i[create update destroy]
      end
    end
  end
end
