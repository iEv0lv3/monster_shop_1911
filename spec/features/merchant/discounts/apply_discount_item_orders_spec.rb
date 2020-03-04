require 'rails_helper'

RSpec.describe 'As a regular user', type: :feature do
  before :each do
    @regular_user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)

    @merchant = create(:random_merchant)
    @discount1 = create(:discount, item_count: 3, percent: 5, merchant: @merchant)
    @discount2 = create(:discount, item_count: 5, percent: 10, merchant: @merchant)

    @merchant2 = create(:random_merchant)
    @discount3 = create(:discount, item_count: 3, percent: 5, merchant: @merchant2)
    @discount4 = create(:discount, item_count: 5, percent: 10, merchant: @merchant2)

    @item1 = create(:random_item, merchant: @merchant, price: 100.00, inventory: 200)
    @item2 = create(:random_item, merchant: @merchant2, price: 100.00, inventory: 200)
  end

  describe "When I visit my cart and click 'Checkout'" do
    it 'Any included discounts are displayed and reflected in the item order price' do
      visit item_path(@item1)

      click_button 'Add To Cart'

      visit item_path(@item2)

      click_button 'Add To Cart'

      visit cart_path

      within("#cart-item-#{@item1.id}") do
        click_on '+'
      end

      within("#cart-item-#{@item1.id}") do
        click_on '+'
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(3)
      end

      expect(page).to have_content(@discount1.name)

      within("#cart-item-#{@item2.id}") do
        click_on '+'
      end

      within("#cart-item-#{@item2.id}") do
        click_on '+'
      end

      within("#cart-item-#{@item2.id}") do
        click_on '+'
      end

      within("#cart-item-#{@item2.id}") do
        click_on '+'
      end

      within("#cart-item-#{@item2.id}") do
        expect(page).to have_content(5)
      end

      expect(page).to have_content(@discount4.name)

      click_link 'Checkout'

      expect(current_path).to eq(new_profile_order_path)

      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount4.name)

      within("#order-item-#{@item1.id}") do
        expect(page).to have_content(3)
        expect(page).to have_content("$95.00")
      end

      within("#order-item-#{@item2.id}") do
        expect(page).to have_content(5)
        expect(page).to have_content("$90.00")
      end

      expect(page).to have_content("Total: $735.00")

      fill_in :name, with: 'Michelle Obama'
      fill_in :address, with: '1600 Pennsylvania Ave'
      fill_in :city, with: 'Washington DC'
      fill_in :state, with: 'DC'
      fill_in :zip, with: '20030'

      click_button 'Create Order'

      expect(current_path).to eq(profile_orders_path)
      expect(page).to have_content('Your order was created.')

      @new_order = Order.last

      within("#order-#{@new_order.id}") do
        click_link @new_order.id.to_s
      end

      expect(current_path).to eq(profile_order_path(@new_order))

      expect(page).to have_content("Grand total: $735.00")

      @item_orders = @new_order.item_orders

      within("#item_order-#{@item_orders[0].id}") do
        expect(page).to have_content("Price: $95.00")
        expect(page).to have_content("Amount: 3")
        expect(page).to have_content("Subtotal: $285.00")
      end

      within("#item_order-#{@item_orders[1].id}") do
        expect(page).to have_content("Price: $90.00")
        expect(page).to have_content("Amount: 5")
        expect(page).to have_content("Subtotal: $450.00")
      end
    end
  end
end
