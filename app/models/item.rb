class Item < ApplicationRecord
  belongs_to :card
  has_many :period_summaries, dependent: :destroy

  def count_for(date)
    period_summaries.where(date: date).first&.count || 0
  end

  def add_check(client_date)
    today = Date.parse(client_date)
    existing_summary = period_summaries.where(date: today).first

    if existing_summary
      new_count = existing_summary.count + 1

      existing_summary.update(
        count: new_count,
        score: new_count * score
      )
    else
      period_summaries.create(
        date: today,
        year: today.year,
        month: today.month,
        week: today.cweek,
        count: 1,
        score: score,
        card_id: card.id
      )
    end
  end
end
