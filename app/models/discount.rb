class Discount < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true, length: { in: 6..90 }
  validates :item_count, presence: true, numericality: { greater_than: 0, less_than: 10000 }
  validates :percent, presence: true, numericality: { greater_than: 0, less_than: 100 }
end
