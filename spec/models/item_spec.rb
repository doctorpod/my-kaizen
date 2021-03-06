require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { card.items.create!(title: 'Foo', score: 0.5) }

  let(:uid) { '123' }
  let(:profile) { Profile.create(uid: uid) }
  let(:card) { profile.cards.create!(title: 'Bobbins') }
  let(:client_date) { '15/04/2019' }

  describe '#increment_check' do
    before do
      subject.increment_check(client_date, profile.id)
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
      before { subject.increment_check(client_date, profile.id) }

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

  describe '#decrement_check' do
    context 'currently 0' do
      before { subject.decrement_check(client_date) }

      it 'returns without action' do
        expect(subject.period_summaries.count).to eq(0)
      end
    end

    context 'currently 1' do
      let(:date) { Date.parse(client_date) }
      let!(:period_summary) do
        subject.period_summaries.create!(
          date: date,
          year: date.year,
          month: date.month,
          week: date.cweek,
          count: 1,
          score: 0.5,
          card_id: card.id,
          profile_id: profile.id
        )
      end

      before { subject.decrement_check(client_date) }

      it 'period summary deleted' do
        expect(PeriodSummary.where(id: period_summary.id).count).to eq(0)
      end
    end

    context 'currently 2' do
      let(:date) { Date.parse(client_date) }
      let!(:period_summary) do
        subject.period_summaries.create!(
          date: date,
          year: date.year,
          month: date.month,
          week: date.cweek,
          count: 2,
          score: 1.0,
          card_id: card.id,
          profile_id: profile.id
        )
      end

      before { subject.decrement_check(client_date) }

      it 'count updated' do
        expect(period_summary.reload.count).to eq(1)
      end

      it 'score updated' do
        expect(period_summary.reload.score).to eq(0.5)
      end
    end
  end
end
