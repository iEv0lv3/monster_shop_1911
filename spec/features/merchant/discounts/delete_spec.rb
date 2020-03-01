require 'rails_helper'

RSpec.describe 'As a merchant employee', type: :feature do
  before :each do
    @merchant_user = create(:merchant_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

    @merchant = @merchant_user.merchant
    @discount1 = create(:discount, item_count: 20, percent: 5, merchant: @merchant)
    @discount2 = create(:discount, item_count: 40, percent: 10, merchant: @merchant)
  end

  describe "When I visit a discount's show page I see a link 'Delete'" do
    it 'I click Delete and the discount is destroyed' do
      visit merchant_discount_path(@discount1)

      expect(page).to have_content(@discount1.name)

      click_link 'Delete'

      expect(page).to have_content("#{@discount1.name} has been deleted.")

      expect(current_path).to eq(merchant_discounts_path)
      expect(page).to_not have_css("#discount-#{@discount1.id}")

    end
  end

  describe "If another employee deletes the discount, and I'm on that discount's showpage" do
    it "I can't delete that discount, and a flash message is displayed" do

      visit merchant_discounts_path

      within("#discount-#{@discount2.id}") do
        click_link @discount2.name
      end

      expect(current_path).to eq(merchant_discount_path(@discount2))
      expect(page).to have_content(@discount2.name)

      discount_id = @discount2.id
      @discount2.destroy

      click_link 'Delete'

      expect(page).to have_content('Discount already deleted.')
      expect(current_path).to eq(merchant_discounts_path)

      expect(page).to_not have_css("#discount-#{discount_id}")
    end
  end
end
