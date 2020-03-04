require 'rails_helper'

RSpec.describe 'As an admin', type: :feature do
  before :each do
    @user = create(:admin_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @merchant = create(:random_merchant)
    @item1 = create(:random_item, merchant: @merchant)
    @item2 = create(:random_item, merchant: @merchant)
    @item3 = create(:random_item, merchant: @merchant)
    @item4 = create(:random_item, merchant: @merchant)
    @item5 = create(:random_item, merchant: @merchant)
    @order1 = create(:random_order)
    @order2 = create(:random_order)
    @order3 = create(:random_order)
    @item_order = create(:random_item_order, order: @order1, item: @item1)
    @item_order = create(:random_item_order, order: @order2, item: @item2)
    @item_order = create(:random_item_order, order: @order3, item: @item3)
  end

  describe "I visit a merchant's dashboard and click link 'My Items'" do
    it 'I see all item details the merchant would see' do
      visit "/admin/merchants/#{@merchant.id}/items"

      within("#item-#{@item1.id}") do
        expect(page).to have_link(@item1.name)
        expect(page).to have_link(@merchant.name)
        expect(page).to have_link('Delete')
        expect(page).to have_link('Edit')
        expect(page).to have_link('Deactivate')
        expect(page).to have_content('Active')
        expect(page).to have_content(@item1.inventory)
        expect(page).to have_content(@item1.price)
        expect(page).to have_content(@item1.description)
      end

      within("#item-#{@item2.id}") do
        expect(page).to have_link(@item2.name)
        expect(page).to have_link(@merchant.name)
        expect(page).to have_link('Delete')
        expect(page).to have_link('Edit')
        expect(page).to have_link('Deactivate')
        expect(page).to have_content('Active')
        expect(page).to have_content(@item2.inventory)
        expect(page).to have_content(@item2.price)
        expect(page).to have_content(@item2.description)
      end

      within("#item-#{@item3.id}") do
        expect(page).to have_link(@item3.name)
        expect(page).to have_link(@merchant.name)
        expect(page).to have_link('Delete')
        expect(page).to have_link('Edit')
        expect(page).to have_link('Deactivate')
        expect(page).to have_content('Active')
        expect(page).to have_content(@item3.inventory)
        expect(page).to have_content(@item3.price)
        expect(page).to have_content(@item3.description)
      end
    end
  end

  describe 'I can activate and deactivate items' do
    it 'I click deactivate and activate' do

      visit "/admin/merchants/#{@merchant.id}/items"

      within("#item-#{@item1.id}") do
        click_link 'Deactivate'
      end

      expect(page).to have_content("#{@item1.name} is no longer for sale.")

      within("#item-#{@item1.id}") do
        click_link 'Activate'
      end

      expect(page).to have_content("#{@item1.name} is now available for sale.")
    end

    describe "When I click Delete" do
      it 'I can delete items from the merchant' do

        visit "/admin/merchants/#{@merchant.id}/items"

        within("#item-#{@item1.id}") do
          click_link 'Delete'
        end

        expect(page).to have_content("Cannot delete an item with orders.")

        visit "/admin/merchants/#{@merchant.id}/items"

        within("#item-#{@item4.id}") do
          click_link 'Delete'
        end

        expect(page).to have_content("'#{@item4.name}' has been deleted.")
      end
    end

    describe "When I click Edit" do
      it 'I can edit items' do

        visit "/admin/merchants/#{@merchant.id}/items"

        within("#item-#{@item1.id}") do
          click_link 'Edit'
        end

        expect(current_path).to eq("/admin/merchants/#{@merchant.id}/items/#{@item1.id}/edit")

        expect(page).to have_field('name', with: "#{@item1.name}")
        expect(page).to have_field('description', with: "#{@item1.description}")
        expect(page).to have_field('price', with: "#{@item1.price}")
        expect(page).to have_field('image', with: "#{@item1.image}")
        expect(page).to have_field('inventory', with: "#{@item1.inventory}")

        fill_in :name, with: 'Baller Item'
        fill_in :description, with: ''

        click_button 'Update Item'

        expect(page).to have_content("Description can't be blank")

        fill_in :name, with: 'Baller Item'
        fill_in :description, with: 'An item for absolute ballers'

        click_button 'Update Item'

        expect(current_path).to eq("/admin/merchants/#{@merchant.id}/items")

        within("#item-#{@item1.id}") do
          expect(page).to have_link('Baller Item')
          expect(page).to have_link(@merchant.name)
          expect(page).to have_link('Delete')
          expect(page).to have_link('Edit')
          expect(page).to have_link('Deactivate')
          expect(page).to have_content('Active')
          expect(page).to have_content(@item1.inventory)
          expect(page).to have_content(@item1.price)
          expect(page).to have_content('An item for absolute ballers')
        end

        within("#item-#{@item1.id}") do
          @item1.reload
          click_link "#{@item1.name}"
        end

        expect(current_path).to eq("/admin/merchants/#{@merchant.id}/items/#{@item1.id}")
      end
    end

    describe "When I click Add Item" do
      it 'I can add a new item to the merchant' do

        visit "/admin/merchants/#{@merchant.id}/items"

        click_link 'Add New Item'

        expect(current_path).to eq("/admin/merchants/#{@merchant.id}/items/new")

        fill_in :name, with: 'Dope Item'
        fill_in :inventory, with: 200
        fill_in :price, with: 25.00
        fill_in :description, with: ''
        click_button 'Create Item'

        expect(page).to have_content("Description can't be blank")

        expect(current_path).to eq("/admin/merchants/#{@merchant.id}/items")

        fill_in :name, with: 'Dope Item'
        fill_in :inventory, with: 200
        fill_in :price, with: 25.00
        fill_in :description, with: 'A dope item for ballers'
        click_button 'Create Item'

        expect(current_path).to eq("/admin/merchants/#{@merchant.id}/items")

        new_item = Item.last

        within("#item-#{new_item.id}") do
          expect(page).to have_link(new_item.name)
          expect(page).to have_link(@merchant.name)
          expect(page).to have_link('Delete')
          expect(page).to have_link('Edit')
          expect(page).to have_link('Deactivate')
          expect(page).to have_content('Active')
          expect(page).to have_content(new_item.inventory)
          expect(page).to have_content(new_item.price)
          expect(page).to have_content(new_item.description)
        end
      end
    end
  end

  describe 'If an item has already been deleted when I click Delete' do
    it 'It will display a flash error message and redirect' do
      visit "/admin/merchants/#{@merchant.id}/items/#{@item5.id}"

      expect(page).to have_link('Delete')

      Item.destroy(@item5.id)

      expect(page).to have_link('Delete')
      click_link 'Delete'

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content('Item already deleted.')
    end
  end
end
