class Item < ApplicationRecord
  belongs_to :card
  has_many :period_summaries, dependent: :destroy

  default_scope { order('score DESC, title ASC') }

  def count_for(date)
    period_summaries.where(date: date).first&.count || '-'
  end

  def increment_check(client_date, profile_id)
    today = Date.parse(client_date)
    found = found_summary(today)

    if found
      update_summary(found, found.count + 1)
    else
      period_summaries.create(
        date: today,
        year: today.year,
        month: today.month,
        week: today.cweek,
        count: 1,
        score: score,
        card_id: card.id,
        profile_id: profile_id
      )
    end
  end

  def decrement_check(client_date)
    today = Date.parse(client_date)
    found = found_summary(today)

    if found
      if found.count <= 1
        found.delete
      else
        update_summary(found, found.count - 1)
      end
    end
  end

  private

  def found_summary(today)
    period_summaries.where(date: today).first
  end

  def update_summary(summary, new_count)
    summary.update(count: new_count, score: new_count * score)
  end
end
