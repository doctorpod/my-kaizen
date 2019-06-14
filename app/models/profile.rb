class Profile < ApplicationRecord
  has_many :cards
  has_many :period_summaries
end
