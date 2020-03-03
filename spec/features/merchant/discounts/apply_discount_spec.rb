require 'rails_helper'

RSpec.describe 'As a regular or merchant user', type: :feature do
  before :each do
    @regular_user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)

    @merchant = create(:random_merchant)
    @discount1 = create(:discount, item_count: 3, percent: 5, merchant: @merchant)
    @discount2 = create(:discount, item_count: 5, percent: 10, merchant: @merchant)

    @merchant2 = create(:random_merchant)
    @discount3 = create(:discount, item_count: 3, percent: 5, merchant: @merchant2)
    @discount4 = create(:discount, item_count: 5, percent: 10, merchant: @merchant2)

    @item1 = create(:random_item, merchant: @merchant, inventory: 200)
    @item2 = create(:random_item, merchant: @merchant2, inventory: 200)

  end

  describe 'When I add enough quantity of a single item to my cart' do
    it 'Any merchant discounts for that item are automatically displayed in my cart' do

      visit item_path(@item1)

      click_button 'Add To Cart'

      expect(page).to have_content("#{@item1.name} was successfully added to your cart.")
      expect(current_path).to eq(items_path)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(2)
      end

      expect(page).to_not have_content(@discount1.name)
      expect(page).to_not have_content(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(3)
      end

      expect(page).to have_content(@discount1.name)
      expect(page).to_not have_content(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("-")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(2)
      end

      expect(page).to_not have_content(@discount1.name)
      expect(page).to_not have_content(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(3)
      end

      expect(page).to have_content(@discount1.name)
      expect(page).to_not have_content(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(4)
      end

      expect(page).to have_content(@discount1.name)
      expect(page).to_not have_content(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(5)
      end

      expect(page).to_not have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(6)
      end

      expect(page).to_not have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("-")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(5)
      end

      expect(page).to_not have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("-")
      end

      within("#cart-item-#{@item1.id}") do
        expect(page).to have_content(4)
      end

      expect(page).to have_content(@discount1.name)
      expect(page).to_not have_content(@discount2.name)

      visit item_path(@item2)

      click_button 'Add To Cart'

      visit cart_path

      within("#cart-item-#{@item2.id}") do
        click_on("+")
      end

      within("#cart-item-#{@item2.id}") do
        expect(page).to have_content(2)
      end

      within("#cart-item-#{@item2.id}") do
        click_on("+")
      end

      within("#cart-item-#{@item2.id}") do
        expect(page).to have_content(3)
      end

      expect(page).to have_content(@discount3.name)
    end
  end
end
