require 'rails_helper'

RSpec.describe Auth0Controller, type: :controller do
  describe '#callback' do
    before { get :callback }

    it 'sets user info' do
      expect(session.keys).to include('userinfo')
    end

    it 'redirects to /cards' do
      expect(response).to redirect_to('/cards')
    end
  end

  describe '#failure' do
    it "returns http success" do
      get :failure
      expect(response).to have_http_status(:success)
    end
  end

  describe '#logout' do
    before { get :logout }

    it 'resets session' do
      expect(session.keys).not_to include('userinfo')
    end

    it 'redirects to auth0' do
      expect(response).to have_http_status(:redirect)
    end
  end
end
