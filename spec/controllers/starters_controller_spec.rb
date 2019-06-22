require 'rails_helper'

RSpec.describe StartersController, type: :controller do
  let(:uid) { '123' }
  let!(:profile) { Profile.create(uid: uid) }

  context 'signed in' do
    before do
      session[:userinfo] = { 'uid' => uid }
    end

    describe "GET #index" do
      before { get :index }

      it 'assigns @starters' do
        expect(assigns(:starters)).not_to be_nil
      end

      it 'renders index' do
        assert_template 'starters/index'
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST #copy" do
      before { post :copy, params: { index: 0 } }

      it 'creates a copy' do
        expect(profile.cards.count).to eq(1)
      end

      it 'redirects to /cards' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(cards_url)
      end
    end
  end

end
