Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :parcels
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "parcels#new"
end
