class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, length: { maximum: 25 }
  validates_presence_of :item_count, numericality: true, greater_than: 0, less_than: 10000
  validates_presence_of :percent, numericality: true, greater_than: 0, less_than: 100
end
