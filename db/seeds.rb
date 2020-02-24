# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.destroy_all
User.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

merchant_user = User.create(name: "John Bill",
  address: "1491 Street St",
  city: "Denver",
  state: "CO",
  zip: "801231",
  email: "john@mail.com",
  password: "burgers",
  password_confirmation: "burgers",
  role: 1,
  merchant: bike_shop
)

admin_user = User.create(name: "John Bill",
  address: "1491 Street St",
  city: "Denver",
  state: "CO",
  zip: "801231",
  email: "kate@mail.com",
  password: "burgers",
  password_confirmation: "burgers",
  role: 2
)

regular_user = User.create(name: "John Bill",
  address: "1491 Street St",
  city: "Denver",
  state: "CO",
  zip: "801231",
  email: "bill@mail.com",
  password: "burgers",
  password_confirmation: "burgers",
  role: 0
)


order = Order.create(name: "John Bill", address: "1491 Street St", city: "Denver", state: "CO", zip: "80123", user: regular_user, status: 'pending')
# item_order = ItemOrder.create(item: tire, order: order, quanity: 100, price: 2)

tire.item_orders.create(quantity: 100, price: 2, order: order)
