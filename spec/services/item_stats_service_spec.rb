require 'rails_helper'

RSpec.describe ItemStatsService do
  let(:profile) { Profile.create }
  let(:card) { profile.cards.create(title: 'Foo') }
  let!(:item1) { card.items.create(title: 'Foo', score: 1) }
  let!(:item2) { card.items.create(title: 'Bar', score: 1) }

  let!(:period_summary11) do 
    PeriodSummary.create(
      date: Date.today,
      item_id: item1.id,
      card_id: card.id,
      profile_id: profile.id,
      count: 1
    )
  end

  let!(:period_summary12) do 
    PeriodSummary.create(
      date: Date.today-1,
      item_id: item1.id,
      card_id: card.id,
      profile_id: profile.id,
      count: 2
    )
  end

  let!(:period_summary2) do 
    PeriodSummary.create(
      date: Date.today-1,
      item_id: item2.id,
      card_id: card.id,
      profile_id: profile.id,
      count: 1
    )
  end

  subject { described_class.all(profile, Date.today) }

  it 'works' do
    expect(subject).to eq(
      {
        item1.id => {
          today_count: 1,
          recent_count: 3
        },
        item2.id => {
          today_count: '-',
          recent_count: 1
        }
      }
    )
  end
end