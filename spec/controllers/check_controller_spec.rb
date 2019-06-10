require 'rails_helper'

RSpec.describe CheckController, type: :controller do
  describe 'POST /checks' do
    let(:card) { Card.create!(title: 'My card') }
    let(:item) { card.items.create!(description: 'Foo bar') }

    let(:attributes) do
      { item_id: item.id, client_date: '15/04/2019' }
    end

    context 'Not signed in' do
      before(:each) do
        post :create, params: attributes
      end

      it_behaves_like 'redirect home'
    end

    context 'Signed in' do
      before do
        session[:userinfo] = { uid: 'bosh123' }
        post :create, params: attributes
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
end
