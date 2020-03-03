FactoryBot.define do
  factory :discount, class: Discount do
    name              { Faker::Hipster.words(number: 3) }
    item_count        { sample[20, 40, 60] }
    percent           { sample[5, 10, 15] }
    association       :merchant, factory: :random_merchant
  end
end
