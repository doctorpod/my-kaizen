require 'rails_helper'

RSpec.describe 'Checks API', type: :request do
  describe 'POST /checks' do
    let(:card) { Card.create!(title: 'My card') }
    let(:item) { card.items.create!(description: 'Foo bar') }

    let(:attributes) do
      { item_id: item.id, client_date: '15/04/2019' }
    end

    before {
      post '/checks', params: attributes
    }

    it 'creates a period summary' do
      expect(item.period_summaries.count).to eq(1)
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end
end
