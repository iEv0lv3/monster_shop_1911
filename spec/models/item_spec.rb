require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @item1 = create(:random_item, price: 100.00)
      @item2 = create(:random_item, price: 100.00)

      @discount1 = create(:discount, item_count: 2, percent: 5)
      @discounts = { @item1 => @discount1 }

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
      expect(@chain.no_orders?).to eq(true)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: create(:regular_user))
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end

    it 'quantity_bought' do
      expect(@chain.quantity_bought).to eq(0)
      order1 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: create(:regular_user))
      order2 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: create(:regular_user))
      order3 = Order.create(name: 'Bleg', address: '123 Blang Ave', city: 'Bershey', state: 'BA', zip: 49494, user: create(:regular_user))
      order4 = Order.create(name: 'Bleg', address: '123 Blang Ave', city: 'Bershey', state: 'BA', zip: 49494, user: create(:regular_user))
      order1.item_orders.create(item: @chain, price: @chain.price, quantity: 1)
      expect(@chain.quantity_bought).to eq(1)
      order2.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.quantity_bought).to eq(3)
      order3.item_orders.create(item: @chain, price: @chain.price, quantity: 3)
      expect(@chain.quantity_bought).to eq(6)
      order4.item_orders.create(item: @chain, price: @chain.price, quantity: 4)
      expect(@chain.quantity_bought).to eq(10)
    end

    it 'popular' do
      item7 = create(:random_item)
      item6 = create(:random_item)
      item5 = create(:random_item)
      super_item = create(:random_item)
      item4 = create(:random_item)
      item3 = create(:random_item)
      item2 = create(:random_item)
      item1 = create(:random_item)

      20.times { create(:random_item_order, item: item1, price: item1.price, quantity: 5) }
      14.times { create(:random_item_order, item: item2, price: item1.price, quantity: 5) }
      11.times { create(:random_item_order, item: item3, price: item1.price, quantity: 5) }
      10.times { create(:random_item_order, item: item4, price: item1.price, quantity: 5) }
      100.times { create(:random_item_order, item: super_item, price: item1.price, quantity: 15) }
      8.times { create(:random_item_order, item: item5, price: item1.price, quantity: 5) }
      3.times { create(:random_item_order, item: item6, price: item1.price, quantity: 5) }
      1.times { create(:random_item_order, item: item7, price: item1.price, quantity: 5) }

      expect(Item.popular(5, "desc")).to eq([super_item, item1, item2, item3, item4])
      expect(Item.popular(5, "asc")).to eq([@chain, item7, item6, item5, item4])
    end

    it 'price_check' do
      expect(@item1.price).to eq(100.00)
      expect(@item1.price_check(@discounts)).to eq(95.00)
    end
  end
end
