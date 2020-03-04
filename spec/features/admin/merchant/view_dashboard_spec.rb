require 'rails_helper'

RSpec.describe 'As an admin', type: :feature do
  before :each do
    @user = create(:admin_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @merchant = create(:random_merchant)
    @item1 = create(:random_item, merchant: @merchant)
    @item2 = create(:random_item, merchant: @merchant)
    @item3 = create(:random_item, merchant: @merchant)
    @order1 = create(:random_order)
    @order2 = create(:random_order)
    @order3 = create(:random_order)
    @item_order = create(:random_item_order, order: @order1, item: @item1)
    @item_order = create(:random_item_order, order: @order2, item: @item2)
    @item_order = create(:random_item_order, order: @order3, item: @item3)
  end

  describe 'When I visit the merchants index page and click a merchant name' do
    it "I'm redirected to the /admin/merchants/:id dashboard page" do
      visit '/merchants'

      within("#merchant-#{@merchant.id}") do
        click_link @merchant.name.to_s
      end

      expect(current_path).to eq(admin_merchant_path(@merchant))

      expect(page).to have_link(@order1.id.to_s)
      expect(page).to have_content(@order1.created_at.to_formatted_s(:long))

      expect(page).to have_link(@order2.id.to_s)
      expect(page).to have_content(@order2.created_at.to_formatted_s(:long))

      expect(page).to have_link(@order3.id.to_s)
      expect(page).to have_content(@order3.created_at.to_formatted_s(:long))

      click_link @order1.id.to_s

      expect(current_path).to eq("/admin/merchants/#{@merchant.id}/orders/#{@order1.id}")
      visit admin_merchant_path(@merchant)

      click_link @order2.id.to_s

      expect(current_path).to eq("/admin/merchants/#{@merchant.id}/orders/#{@order2.id}")
      visit admin_merchant_path(@merchant)

      click_link @order3.id.to_s

      expect(current_path).to eq("/admin/merchants/#{@merchant.id}/orders/#{@order3.id}")
    end
  end
end
