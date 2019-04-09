class Card < ApplicationRecord
  has_many :items, dependent: :destroy

  def total
    items.map { |i| i.score * i.checks.count } .sum.round
  end
end
