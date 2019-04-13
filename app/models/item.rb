class Item < ApplicationRecord
  belongs_to :card
  has_many :checks, dependent: :destroy
  has_many :period_summaries, dependent: :destroy

  def count_today
    period_summaries.where(date: Date.today).first&.count || 0
  end

  def count_yesterday
    period_summaries.where(date: (Date.today-1)).first&.count || 0
  end

  def create_check
    checks.create!
    today = Date.today
    count = count_on(today)

    existing_summary = period_summaries.where(date: today).first

    if existing_summary
      existing_summary.update(
        count: count,
        score: count * score
      )
    else
      period_summaries.create(
        date: today,
        year: today.year,
        month: today.month,
        week: today.cweek,
        count: count,
        score: count * score,
        card_id: card.id
      )
    end
  end

  private

  def count_on(date)
    checks.where(
      created_at: (date.beginning_of_day..date.end_of_day)
    ).count
  end
end
