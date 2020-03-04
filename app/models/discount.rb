class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, length: { in: 6..50 }
  validates_presence_of :item_count, numericality: { greater_than: 0, less_than: 10000 }
  validates_presence_of :percent, numericality: { greater_than: 0, less_than: 100 }
end
