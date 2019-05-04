class Card < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :period_summaries, dependent: :destroy

  AVG_RANGE = 10
  REWARD = '&#x1F44D;' # Thumbs up

  def score_today(date)
    @score_today ||= format score_today_float(date)
  end

  def score_yesterday(date)
    @score_yesterday ||= format score_yesterday_float(date)
  end

  def recent_average(date)
    @recent_average ||= format recent_average_float(date)
  end

  def rewards(date)
    [].tap do |out|
      out << REWARD if score_today_float(date) > score_yesterday_float(date)
      out << REWARD if score_today_float(date) > recent_average_float(date)
    end
  end

  private

  def recent_scores(date)
    @recent_scores ||= period_summaries
      .where('date >= ?', date-(AVG_RANGE+1))
      .group(:date)
      .order(:date)
      .sum(:score)
  end

  def score_today_float(date)
    @score_today_float ||= (recent_scores(date)[date] || 0.0)
  end

  def score_yesterday_float(date)
    @score_yesterday_float ||= (recent_scores(date)[date-1] || 0.0)
  end

  def recent_average_float(date)
    @recent_average_float ||= begin
      recent = recent_scores(date).select { |dt, _score| dt < (date - 1) }
      return 0.0 if recent.empty?

      total = recent.inject(0) { |memo, (_date, score)| memo += score }
      total.to_f / recent.size
    end
  end
  def format(num)
    "%.2f" % num
  end
end
