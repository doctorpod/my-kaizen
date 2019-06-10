require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:card) { Card.create! }
  let(:title) { 'My title' }

  let(:card_params) do
    {
      card: {
        title: title,
        description: 'My desc'
      }
    }
  end

  describe '#index' do
    context 'Not signed in' do
      before { get :index }
      it_behaves_like 'redirect home'
    end

    context 'Signed in' do
      before do
        session[:userinfo] = { uid: '123' }
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#deck (JS call)' do
    context 'Not signed in' do
      before { get :deck }
      it_behaves_like 'redirect home'
    end

    context 'Signed in' do
      before do
        session[:userinfo] = { uid: '123' }
        get :deck, params: { client_date: '15/04/2019' }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#new' do
    context 'not signed in' do
      before { get :new }
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { uid: '123' }
        get :new
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#create' do
    context 'not signed in' do
      before { post :create, params: card_params }
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { uid: '123' }
      end

      it 'creates card' do
        expect{post :create, params: card_params}
          .to change{Card.count}.from(0).to(1)
      end

      it "redirects to /cards" do
        post :create, params: card_params
        expect(response).to redirect_to(cards_url)
      end
    end
  end

  describe '#edit' do
    context 'not signed in' do
      before { get :edit, params: {id: card.id} }
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { uid: '123' }
        get :edit, params: {id: card.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#update' do
    context 'not signed in' do
      before { put :update, params: {id: card.id}.merge(card_params) }
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { uid: '123' }
        put :update, params: {id: card.id}.merge(card_params)
      end

      it 'updates card' do
        expect(card.reload.title).to eq(title)
      end

      it "redirects to /cards" do
        expect(response).to redirect_to(cards_url)
      end
    end
  end

  describe '#destroy' do
    before { card }

    context 'not signed in' do
      before { delete :destroy, params: {id: card.id}}
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { uid: '123' }
      end

      it 'deletes item' do
        expect{delete :destroy, params: {id: card.id}}
          .to change{Card.count}.from(1).to(0)
      end

      it "redirects to /cards" do
        delete :destroy, params: {id: card.id}
        expect(response).to redirect_to(cards_url)
      end
    end
  end
end
