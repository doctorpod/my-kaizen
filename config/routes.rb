Rails.application.routes.draw do
  post 'checks', to: 'check#create'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
