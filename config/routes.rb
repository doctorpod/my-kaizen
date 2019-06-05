Rails.application.routes.draw do
  resources :cards
  resources :items
  post '/checks', to: 'check#create'
  get '/home/index'

  # Needed to overcome the issue of dropdowns intermitently not working on reloading of home page
  put '/cancel', to: redirect('/', status: 302)

  root 'home#index'
end
