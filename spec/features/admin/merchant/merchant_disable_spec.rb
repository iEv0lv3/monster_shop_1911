require 'rails_helper'
RSpec.describe "on the admin merchant index" do
  it "shows a button to enable or disable merchant" do
    user = create(:admin_user)
    merchant = create(:random_merchant)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/admin/merchants"

    within "#merchant-#{merchant.id}" do
      expect(page).to have_link("#{merchant.name}")
      click_link "#{merchant.name}"
      expect(current_path).to eq(admin_merchant_path(merchant))
    end

    visit "/admin/merchants"

    within "#merchant-#{merchant.id}" do
      expect(page).to have_button("Disable")
      expect(page).not_to have_button("Enable")
      click_on "Disable"
    end
    expect(page).to have_content("#{merchant.name} has been deactivated.")
    
    expect(current_path).to eq("/admin/merchants")

    within "#merchant-#{merchant.id}" do
      expect(page).not_to have_button("Disable")
      expect(page).to have_button("Enable")
      click_on "Enable"
    end
    expect(page).to have_content("#{merchant.name} has been activated.")
  end

  it "disables items also" do
    customer = create(:regular_user)
    user = create(:admin_user)
    merchant = create(:random_merchant)
    merchant_2 = create(:random_merchant)
    item1 = create(:random_item, merchant: merchant)
    item2 = create(:random_item, merchant: merchant)
    item3 = create(:random_item, merchant: merchant)
    item4 = create(:random_item, merchant: merchant)
    item5 = create(:random_item, merchant: merchant_2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit "/items"

    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
    expect(page).to have_content(item3.name)
    expect(page).to have_content(item4.name)
    expect(page).to have_content(item5.name)

    visit "/admin/merchants"
    
    within "#merchant-#{merchant.id}" do
      click_button "Disable"
    end
    click_on "Log Out"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(customer)
    visit "/items"
    expect(page).not_to have_content(item1.name)
    expect(page).not_to have_content(item2.name)
    expect(page).not_to have_content(item3.name)
    expect(page).not_to have_content(item4.name)
    expect(page).to have_content(item5.name)

    click_on "Log Out"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/admin/merchants"
    within "#merchant-#{merchant.id}" do
      click_button "Enable"
    end
    click_on "Log Out"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(customer)
    visit "/items"
    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
    expect(page).to have_content(item3.name)
    expect(page).to have_content(item4.name)
    expect(page).to have_content(item5.name)
  end

  it "can enable merchants from merchant index" do
    user = create(:admin_user)
    merchant = create(:random_merchant, active?: false)
    merchant_2 = create(:random_merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/merchants"

    within "#merchant-#{merchant.id}" do
      click_button "Enable"
    end
    
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("#{merchant.name} has been activated.")
  end
end

