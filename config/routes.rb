Rails.application.routes.draw do
  get '/', to: 'home#index'
  get '/help', to: 'home#help'

  get '/cards/deck', to: 'cards#deck'
  resources :cards

  resources :items

  put '/checks/increment', to: 'check#increment'
  put '/checks/decrement', to: 'check#decrement'

  # Needed to overcome the issue of dropdowns intermitently not working on reloading of cards page
  put '/cancel', to: redirect('/cards', status: 302)

  # For selecting & copying starter cards
  get '/starters', to: 'starters#index'
  post '/starters/copy', to: 'starters#copy'

  # Oauth routes
  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/logout' => 'auth0#logout'

  root 'home#index'
end
