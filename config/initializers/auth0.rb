Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    ENV['OAUTH_CLIENT_ID'],
    ENV['OAUTH_CLIENT_SECRET'],
    ENV['OAUTH_DOMAIN'],
    callback_path: '/auth/oauth2/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end
