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

  def self.most_popular(limit)
     Item.select("items.*, SUM(quantity) AS total")
       .joins(:item_orders)
       .group(:id)
       .order("total desc")
       .limit(limit)
  end

  def self.least_popular(limit)
     Item.select("items.*, SUM(quantity) AS total")
       .left_outer_joins(:item_orders)
       .group(:id)
       .order("total asc")
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

end
