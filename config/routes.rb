Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :parcels
  
  root "parcels#new"
end
