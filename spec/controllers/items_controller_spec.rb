require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:uid) { '123' }
  let!(:profile) { Profile.create(uid: uid) }
  let(:card) { profile.cards.create! }
  let(:item) { card.items.create! }
  let(:title) { 'My item' }

  let(:item_params) do
    {
      item: {
        title: title,
        description: 'My desc',
        score: 1.0,
        card_id: card.id
      }
    }
  end

  describe '#new' do
    context 'not signed in' do
      before { get :new, params: {card_id: card.id} }
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { 'uid' => '123' }
        get :new, params: {card_id: card.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#create' do
    context 'not signed in' do
      before { post :create, params: item_params }
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { 'uid' => '123' }
      end

      it 'creates item' do
        expect{post :create, params: item_params}
          .to change{card.items.count}.from(0).to(1)
      end

      it "redirects to /cards" do
        post :create, params: item_params
        expect(response).to redirect_to(cards_url)
      end
    end
  end

  describe '#edit' do
    context 'not signed in' do
      before { get :edit, params: {id: item.id} }
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { 'uid' => '123' }
        get :edit, params: {id: item.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#update' do
    context 'not signed in' do
      before { put :update, params: {id: item.id}.merge(item_params) }
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { 'uid' => '123' }
        put :update, params: {id: item.id}.merge(item_params)
      end

      it 'updates item' do
        expect(item.reload.title).to eq(title)
      end

      it "redirects to /cards" do
        expect(response).to redirect_to(cards_url)
      end
    end
  end

  describe '#destroy' do
    before { item }

    context 'not signed in' do
      before { delete :destroy, params: {id: item.id}}
      it_behaves_like 'redirect home'
    end

    context 'signed in' do
      before do
        session[:userinfo] = { 'uid' => '123' }
      end

      it 'deletes item' do
        expect{delete :destroy, params: {id: item.id}}
          .to change{card.items.count}.from(1).to(0)
      end

      it "redirects to /cards" do
        delete :destroy, params: {id: item.id}
        expect(response).to redirect_to(cards_url)
      end
    end
  end
end
