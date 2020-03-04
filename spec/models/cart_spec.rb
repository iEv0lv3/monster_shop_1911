require 'rails_helper'

describe "instance methods" do
  before(:each) do
    @merchant = create(:random_merchant)

    @item1 = create(:random_item, merchant: @merchant, inventory: 4)
    @cart = Cart.new({@item1.id.to_s => 1})

    @item = create(:random_item, price: 100.00, merchant: @merchant)
    @item2 = create(:random_item, price: 100.00, merchant: @merchant)

    @discount1 = create(:discount, item_count: 2, percent: 5, merchant: @merchant)
    @discount2 = create(:discount, item_count: 5, percent: 10, merchant: @merchant)
  end

  it 'edit_quantity' do
    params = {item_id: @item1.id.to_s, value: "add"}
    expect(@cart.edit_quantity(params)).to eq(2)

    params = {item_id: @item1.id.to_s, value: "sub"}
    @cart.edit_quantity(params)
    expect(@cart.contents[params[:item_id]]).to eq(1)
    expect(@cart.edit_quantity(params)).to eq(0)
  end

  it 'inventory_limit' do
    expect(@cart.inventory_limit?("max", @item1)).to eq(false)
    @cart.contents[@item1.id.to_s] = 4
    expect(@cart.inventory_limit?("max", @item1)).to eq(true)

    expect(@cart.inventory_limit?("min", @item1)).to eq(false)
    @cart.contents[@item1.id.to_s] = 0
    expect(@cart.inventory_limit?("min", @item1)).to eq(true)
  end

  it 'discount_check' do
    @cart = { @item => 2, @item2 => 3 }
    # Other than rails s, I'm having difficulty creating a good test
    # active_discounts = @cart.discount_check

    # expect(active_discounts[@item]).to eq(@discount1)
    # expect(active_discounts[@item2]).to eq(@discount2)
  end
end
