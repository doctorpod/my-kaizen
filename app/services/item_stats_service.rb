class ItemStatsService
  def self.all(profile, reference_date)
    today = profile.period_summaries
      .where(date: reference_date)
      .group(:item_id)
      .sum(:count)

    recent = profile.period_summaries
      .where('date >= ?', reference_date-Card::AVG_RANGE)
      .group(:item_id)
      .sum(:count)

    (today.keys + recent.keys).uniq.reduce({}) do |h, key|
      h[key] = {
        today_count: today[key] || '-',
        recent_count: recent[key] || 0
      }
      h
    end
  end

  def self.item(item, reference_date)
    {
      item: {
        id: item.id,
        count: item.period_summaries.where(date: reference_date).first&.count || '-',
        recent_count: item.period_summaries
          .where('date >= ?', reference_date-Card::AVG_RANGE)
          .sum(:count),
        card: {
          id: item.card_id,
          rewards: item.card.rewards(reference_date),
          scores: {
            today: item.card.score_today(reference_date),
            yesterday: item.card.score_yesterday(reference_date),
            recent_average: item.card.recent_average(reference_date)
          }
        }
      }
    }
  end
end