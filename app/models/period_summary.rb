class PeriodSummary < ApplicationRecord
  belongs_to :profile
  belongs_to :item
  belongs_to :card
end
