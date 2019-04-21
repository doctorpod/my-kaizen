require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { card.items.create!(title: 'Foo', score: 0.5) }

  let(:card) { Card.create!(title: 'Bobbins') }
  let(:client_date) { '15/04/2019' }

  describe '#add_check' do
    before do
      subject.add_check(client_date)
    end

    describe 'period summary' do
      let(:period_summary) { subject.period_summaries.first }

      it 'one is created' do
        expect(subject.period_summaries.count).to eq(1)
      end

      it 'has the client date' do
        expect(period_summary.date).to eq(Date.parse(client_date))
      end

      it 'has a count of 1' do
        expect(period_summary.count).to eq(1)
      end

      it 'has a score of 0.5 (1*0.5)' do
        expect(period_summary.score).to eq(0.5)
      end

      it 'has correct card id' do
        expect(period_summary.card_id).to be(card.id)
      end
    end

    context 'subsequent invocation on same day' do
      before { subject.add_check(client_date) }

      describe 'period summary' do
        let(:period_summary) { subject.period_summaries.first }

        it 'original is updated' do
          expect(subject.period_summaries.count).to eq(1)
        end

        it 'has a count of 2' do
          expect(period_summary.count).to eq(2)
        end

        it 'has a score of 1.0 (2*0.5)' do
          expect(period_summary.score).to eq(1.0)
        end

        it 'has correct card id' do
          expect(period_summary.card_id).to be(card.id)
        end
      end
    end
  end
end
