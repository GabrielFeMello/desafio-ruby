Rails.application.routes.draw do

  post 'transations/cnab_upload'
  resources :transations
  resources :representatives
  resources :stores
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
