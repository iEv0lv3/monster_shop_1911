class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :inventory, greater_than: 0, less_than_or_equal_to: 999999

  def self.popular(limit, order)
    left_outer_joins(:item_orders)
      .group(:id)
      .order("COALESCE(SUM(quantity), 0) #{order}, items.id")
      .limit(limit)
  end

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def quantity_bought
    item_orders.sum(:quantity)
  end

  def price_check(discounts)
    if discounts[self] == 0
      price
    else
      price - (price * discounts[self].percent / 100)
    end
  end
end
