class Item < ApplicationRecord
  belongs_to :card
  has_many :checks
end
