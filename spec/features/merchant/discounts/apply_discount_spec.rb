require 'rails_helper'

RSpec.describe 'As a regular or merchant user', type: :feature do
  before :each do
    @merchant_user = create(:merchant_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

    @merchant = @merchant_user.merchant
    @discount1 = create(:discount, item_count: 3, percent: 5, merchant: @merchant)
    @discount2 = create(:discount, item_count: 5, percent: 10, merchant: @merchant)

    @item1 = create(:random_item, merchant: @merchant, inventory: 200)
    @item2 = create(:random_item, merchant: @merchant, inventory: 200)

  end

  describe 'When I add 20 quantity of a single item to my cart' do
    it 'Any merchant discounts for that item are automatically displayed in my cart' do
      visit merchant_item_path(@item1)

      click_button 'Add To Cart'

      expect(page).to have_content("#{@item1.name} was successfully added to your cart.")
      expect(current_path).to eq(items_path)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      expect(page).to have_content(2)
      expect(page).to_not have_link(@discount1.name)
      expect(page).to_not have_link(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      expect(page).to have_content(3)

      expect(page).to have_link(@discount1.name)
      expect(page).to_not have_link(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("-")
      end

      expect(page).to have_content(2)

      expect(page).to_not have_link(@discount1.name)
      expect(page).to_not have_link(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      expect(page).to have_content(3)
      expect(page).to have_link(@discount1.name)
      expect(page).to_not have_link(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      expect(page).to have_content(4)

      expect(page).to have_link(@discount1.name)
      expect(page).to_not have_link(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      expect(page).to have_content(5)

      expect(page).to_not have_link(@discount1.name)
      expect(page).to have_link(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("+")
      end

      expect(page).to have_content(6)

      expect(page).to_not have_link(@discount1.name)
      expect(page).to have_link(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("-")
      end

      expect(page).to have_content(5)
      expect(page).to_not have_link(@discount1.name)
      expect(page).to have_link(@discount2.name)

      visit cart_path

      within("#qty") do
        click_on("-")
      end

      expect(page).to have_content(4)

      expect(page).to have_link(@discount1.name)
      expect(page).to_not have_link(@discount2.name)
    end
  end
end
