class Auth0Controller < ApplicationController
  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:userinfo] = request.env['omniauth.auth']

    # Create this profile if it doesn't already exist
    Profile.find_or_create_by(uid: uid)

    # Redirect to the URL you want after successful auth
    redirect_to cards_url
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end

  def logout
    reset_session
    redirect_to logout_url.to_s
  end

  private

  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: client_id
    }

    URI::HTTPS.build(host: domain, path: '/v2/logout', query: to_query(request_params))
  end

  def to_query(hash)
    hash.map { |k, v| "#{k}=#{URI.escape(v)}" unless v.nil? }.reject(&:nil?).join('&')
  end

  def domain
    ENV['OAUTH_DOMAIN']
  end

  def client_id
    ENV['OAUTH_CLIENT_ID']
  end

  def uid
    session[:userinfo]['uid']
  end
end
