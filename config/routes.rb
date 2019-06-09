Rails.application.routes.draw do
  get '/cards/deck', to: 'cards#deck'
  resources :cards
  resources :items
  post '/checks', to: 'check#create'
  get '/dashboard/index'
  # Needed to overcome the issue of dropdowns intermitently not working on reloading of cards page
  put '/cancel', to: redirect('/cards', status: 302)

  # Needed to overcome the issue of dropdowns intermitently not working on reloading of dashboard page
  put '/cancel', to: redirect('/', status: 302)

  root 'home#index'
end
