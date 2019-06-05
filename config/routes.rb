Rails.application.routes.draw do
  resources :cards
  resources :items
  post '/checks', to: 'check#create'
  get '/dashboard/index'

  # Needed to overcome the issue of dropdowns intermitently not working on reloading of dashboard page
  put '/cancel', to: redirect('/', status: 302)

  root 'dashboard#index'
end
