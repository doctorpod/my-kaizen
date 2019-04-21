require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { card.items.create!(title: 'Foo', score: 0.5) }

  let(:card) { Card.create!(title: 'Bobbins') }
  let(:client_date) { Date.today.strftime("%d/%m/%Y") }

  describe '#create_check' do
    before do
      subject.checks.create!
      subject.create_check(client_date)
    end

    it 'creates a check' do
      expect(Check.count).to eq(2)
    end

    describe 'period summary' do
      let(:period_summary) { subject.period_summaries.first }

      it 'one is created' do
        expect(subject.period_summaries.count).to eq(1)
      end

      it 'has the client date' do
        expect(period_summary.date).to eq(Date.parse(client_date))
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

    context 'subsequent invocation on same day' do
      before { subject.create_check(client_date) }

      describe 'period summary' do
        let(:period_summary) { subject.period_summaries.first }

        it 'original is updated' do
          expect(subject.period_summaries.count).to eq(1)
        end

        it 'has a count of 3' do
          expect(period_summary.count).to eq(3)
        end

        it 'has a score of 1.5 (3*0.5)' do
          expect(period_summary.score).to eq(1.5)
        end

        it 'has correct card id' do
          expect(period_summary.card_id).to be(card.id)
        end
      end
    end
  end
end
