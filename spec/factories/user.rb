FactoryBot.define do
  factory :regular_user, class: User do
    name              { GOTFaker::Character.random_name }
    address           { Faker::Address.street_address }
    city              { GOTFaker::Geography.region }
    state             { Faker::Address.state_abbr }
    zip               { Faker::Address.zip }
    email             { Faker::Internet.email }
    password          { "burger32" }
    roll              { 0 }
  end
end
