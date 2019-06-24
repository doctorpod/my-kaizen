require 'rails_helper'

RSpec.describe CheckController, type: :controller do
  let(:uid) { '123' }
  let!(:profile) { Profile.create(uid: uid) }

  describe 'PUT /checks/increment' do
    let(:card) { profile.cards.create!(title: 'My card') }
    let(:item) { card.items.create!(description: 'Foo bar') }

    let(:attributes) do
      { item_id: item.id, client_date: '15/04/2019' }
    end

    context 'Not signed in' do
      before(:each) do
        put :increment, params: attributes
      end

      it_behaves_like 'redirect home'
    end

    context 'Signed in' do
      before do
        session[:userinfo] = { 'uid' => uid }
        put :increment, params: attributes
      end

      it 'creates a period summary' do
        expect(item.period_summaries.count).to eq(1)
      end

      it 'returns http 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns correct data' do
        expect(JSON.parse(response.body)).to eq(
          {
            item: {
              id: item.id,
              count: 1,
              card: {
                id: card.id,
                rewards: [
                  Card::REWARD,
                  Card::REWARD
                ],
                scores: {
                  today: '1.00',
                  yesterday: '0.00',
                  recent_average: '0.00'
                }
              }
            }
          }.with_indifferent_access
        )
      end
    end
  end

  describe 'PUT /checks/decrement' do
    let(:card) { profile.cards.create!(title: 'My card') }
    let(:item) { card.items.create!(description: 'Foo bar') }

    let(:attributes) do
      { item_id: item.id, client_date: '15/04/2019' }
    end

    context 'Not signed in' do
      before(:each) do
        put :decrement, params: attributes
      end

      it_behaves_like 'redirect home'
    end

    context 'Signed in' do
      before do
        session[:userinfo] = { 'uid' => uid }
        put :decrement, params: attributes
      end

      it 'returns http 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns correct data' do
        expect(JSON.parse(response.body)).to eq(
          {
            item: {
              id: item.id,
              count: '-',
              card: {
                id: card.id,
                rewards: [],
                scores: {
                  today: '0.00',
                  yesterday: '0.00',
                  recent_average: '0.00'
                }
              }
            }
          }.with_indifferent_access
        )
      end
    end
  end
end
