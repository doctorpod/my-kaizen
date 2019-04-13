class Card < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :period_summaries, dependent: :destroy

  def total_today
    period_summaries.where(date: Date.today).sum(:score)
  end

  def total_yesterday
    period_summaries.where(date: (Date.today-1)).sum(:score)
  end
end
