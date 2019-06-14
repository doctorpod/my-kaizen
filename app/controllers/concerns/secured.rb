module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to '/' unless session[:userinfo].present?
  end

  def uid
    session[:userinfo]['uid']
  end

  def profile
    @profile ||= Profile.where(uid: uid).first
  end
end
