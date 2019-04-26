class Card < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :period_summaries, dependent: :destroy

  AVG_RANGE = 10

  def score_today(date)
    format period_summaries.where(date: date).sum(:score)
  end

  def score_yesterday(date)
    format period_summaries.where(date: date-1).sum(:score)
  end

  def recent_average(date)
    format period_summaries.where(date: (date-(AVG_RANGE+1)..date-1)).sum(:score) / AVG_RANGE.to_f
  end

  private

  def format(num)
    "%.2f" % num
  end
end
