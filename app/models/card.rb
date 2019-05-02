class Card < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :period_summaries, dependent: :destroy

  AVG_RANGE = 10

  def score_today(date)
    format recent_scores(date)[date] || 0.0
  end

  def score_yesterday(date)
    format recent_scores(date)[date-1] || 0.0
  end

  def recent_average(date)
    recent = recent_scores(date).select { |dt, _score| dt < (date - 1) }
    return "0.00" if recent.empty?

    total = recent.inject(0) { |memo, (_date, score)| memo += score }
    format total.to_f / recent.size
  end

  private

  def recent_scores(date)
    @recent_scores ||= period_summaries
      .where('date >= ?', date-(AVG_RANGE+1))
      .group(:date)
      .order(:date)
      .sum(:score)
  end

  def format(num)
    "%.2f" % num
  end
end
