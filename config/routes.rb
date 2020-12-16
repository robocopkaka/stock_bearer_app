Rails.application.routes.draw do
  resources :stocks, except: %i[new edit]
  resources :bearers, only: %i[create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
