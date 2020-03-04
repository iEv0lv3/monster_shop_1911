require 'rails_helper'

RSpec.describe "As a merchant employee" do
  before :each do
    merchant = create(:random_merchant)
    @merchant2 = create(:random_merchant)
    user = create(:merchant_user, merchant: merchant)
    @item1 = create(:random_item, merchant: merchant)
    @item2 = create(:random_item, merchant: merchant)
    @item3 = create(:random_item, merchant: merchant)
    @item1.reviews.create(title: "Ok", content: "Alright I guess.", rating: 2)
    create(:random_item_order, item: @item2)
    create(:random_item, merchant: merchant)
    @item3 = create(:random_item, merchant: @merchant2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/merchant/items"
  end

  it "I can delete an item" do
    expect(page).to have_css("#item-#{@item1.id}")

    within("#item-#{@item1.id}") { click_link "Delete" }

    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content("'#{@item1.name}' has been deleted.")
    expect(page).to_not have_css("#item-#{@item1.id}")

    visit "/merchants/#{@merchant2.id}/items"

    expect(page).to have_css("#item-#{@item3.id}")
  end

  it "I am notified when I try to delete an item that was already deleted" do
    expect(page).to have_css("#item-#{@item1.id}")
    Item.destroy(@item1.id)
    within("#item-#{@item1.id}") { click_link "Delete" }

    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content('Item already deleted.')
    expect(page).to_not have_css("#item-#{@item1.id}")
  end

  it 'I can not delete items with orders' do
    expect(page).to have_css("#item-#{@item2.id}")

    within("#item-#{@item2.id}") { click_link "Delete" }

    expect(page).to have_content('Cannot delete an item with orders.')
    expect(page).to have_css("#item-#{@item2.id}")
  end

end
