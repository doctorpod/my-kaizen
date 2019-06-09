Rails.application.routes.draw do
  get '/', to: 'home#index'

  get '/cards/deck', to: 'cards#deck'
  resources :cards

  resources :items

  post '/checks', to: 'check#create'

  # Needed to overcome the issue of dropdowns intermitently not working on reloading of cards page
  put '/cancel', to: redirect('/cards', status: 302)

  # Oauth routes
  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/logout' => 'auth0#logout'

  root 'home#index'
end
