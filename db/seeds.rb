# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ItemOrder.destroy_all
Discount.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
alpaca = Merchant.create(name: "Alpaca Connection", address: '245 Wool Way', city: 'Denver', state: 'CO', zip: 80211)
rays = Merchant.create(name: "Ray's Records", address: '123 Fake St', city: 'Denver', state: 'CO', zip: 80222)
jw = Merchant.create(name: "Jordan's Jams and Jams", address: '123 Fruit Loop St', city: 'Denver', state: 'CO', zip: 80222)
davids = Merchant.create(name: "David's Donuts", address: '123 Dunking Donuts Dr', city: 'Denver', state: 'CO', zip: 80222)
kats = Merchant.create(name: "Kathleen's Knits", address: '123 Pumpkin St', city: 'Denver', state: 'CO', zip: 80972)

#discounts
jw.discounts.create(name: 'JW Fiver', item_count: 3, percent: 5 )
jw.discounts.create(name: 'JW Tenner', item_count: 5, percent: 10 )
jw.discounts.create(name: 'JW Fifteener', item_count: 7, percent: 15 )

kats.discounts.create(name: 'Kat Fiver', item_count: 3, percent: 5 )
kats.discounts.create(name: 'Kat Tenner', item_count: 5, percent: 10 )
kats.discounts.create(name: 'Kat Fifteener', item_count: 7, percent: 15 )

davids.discounts.create(name: 'DA Fiver', item_count: 3, percent: 5 )
davids.discounts.create(name: 'DA Tenner', item_count: 5, percent: 10 )
davids.discounts.create(name: 'DA Fifteener', item_count: 7, percent: 15 )

rays.discounts.create(name: 'Ray Fiver', item_count: 3, percent: 5 )
rays.discounts.create(name: 'Ray Tenner', item_count: 5, percent: 10 )
rays.discounts.create(name: 'Ray Fifteener', item_count: 7, percent: 15 )

alpaca.discounts.create(name: 'Alpaca Fiver', item_count: 3, percent: 5 )
alpaca.discounts.create(name: 'Alpaca Tenner', item_count: 5, percent: 10 )
alpaca.discounts.create(name: 'Alpaca Fifteener', item_count: 7, percent: 15 )

dog_shop.discounts.create(name: 'Dog Fiver', item_count: 3, percent: 5 )
dog_shop.discounts.create(name: 'Dog Tenner', item_count: 5, percent: 10 )
dog_shop.discounts.create(name: 'Dog Fifteener', item_count: 7, percent: 15 )

bike_shop.discounts.create(name: 'Bike Fiver', item_count: 3, percent: 5 )
bike_shop.discounts.create(name: 'Bike Tenner', item_count: 5, percent: 10 )
bike_shop.discounts.create(name: 'Bike Fifteener', item_count: 7, percent: 15 )

#all shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

alpaca1 = alpaca.items.create(name: "Fur Hat", description: "So soft!", price: 100, image: "https://sc01.alicdn.com/kf/UT8srXdXWNaXXagOFbXd/856627674/UT8srXdXWNaXXagOFbXd.jpg", inventory: 12)
alpaca2 = alpaca.items.create(name: "Slippers", description: "Walk on clouds!!", price: 100, image: "https://cdn11.bigcommerce.com/s-4cno098ye2/images/stencil/1280x1280/products/399/1327/IMG_5618__70830.1559948927.JPG?c=2&imbypass=on", inventory: 12)
alpaca3 = alpaca.items.create(name: "Teddy Bear", description: "The most snuggly bear around", price: 100, image: "https://cdn11.bigcommerce.com/s-76ikz/images/stencil/original/products/36438/112699/22-100-03443__30612.1539371209.jpg?c=2&imbypass=on&imbypass=on", inventory: 12)
alpaca4 = alpaca.items.create(name: "Scarf", description: "Stay warm and cozy", price: 100, image: "https://assets2.cuyana.com/media/catalog/product/CLCI/aW1hZ2U/MTgwMA/Xw/MTAw/MQ/MQ/MA/MQ/Xw/NWRmMjA1OGY0YTNiOWM0MzI1YWU1MTNlNjNlMzllYjA/9/0/900_20160727_cuyana0202.jpg", inventory: 12)

record1 = rays.items.create(name: "Back to Black - Amy Winehouse", description: "Amazing jazzy pop songstress", price: 30, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/24674111_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 25)
record2 = rays.items.create(name: "Rumours - Fleetwood Mac", description: "Stevie Nicks is a withcy goddess", price: 50, image: "https://www.westelm.com/weimgs/ab/images/wcm/products/201940/0490/fleetwood-mac-rumours-lp-c.jpg", inventory: 60)
record3 = rays.items.create(name: "The White Album- The Beatles", description: "Classic album.", price: 70, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/49830375_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 20)
record4 = rays.items.create(name: "Awaken, My Love! - Childish Gambino", description: "PbR&B", price: 30, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/54839923_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 20)
record5 = rays.items.create(name: "Thriller - Michael Jackson", description: "Dancey and fun", price: 25, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/43513399_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 40)
record6 = rays.items.create(name: "808s And Heartbreak - Kanye West", description: "Hip hop", price: 35, image: "https://s7d5.scene7.com/is/image/UrbanOutfitters/32634917_001_b?$xlarge$&hei=900&qlt=80&fit=constrain", inventory: 40)

jam1 = jw.items.create(name: "Pear Vanilla Ice Jam", description: "Delicious, warm, notes of cinnamon", price: 35, image: "https://i1.wp.com/mountainmamacooks.com/wp-content/uploads/2014/01/pear-vanilla-jam-2.jpg?resize=600%2C397&ssl=1", inventory: 40)
jam2 = jw.items.create(name: "Bohemian Raspberry Jam", description: "Sweet and tangy", price: 35, image: "https://homeinthefingerlakes.com/wp-content/uploads/2018/08/Small-Batch-Raspberry-Jam-in-a-Bread-Machine-1-of-9.jpg", inventory: 40)
jam3 = jw.items.create(name: "Spiced Girls Blackberry Jam", description: "Sweet and tangy", price: 35, image: "https://hips.hearstapps.com/ame-prod-goodhousekeeping-assets.s3.amazonaws.com/main/embedded/10959/blackberry-jam.png", inventory: 40)
jam4 = jw.items.create(name: "Lemon on a Prayer Jam", description: "Tart and fresh", price: 35, image: "https://www.onegoodthingbyjillee.com/wp-content/uploads/2014/11/Lemon-Jam-1.jpg", inventory: 40)
jam5 = jw.items.create(name: "Guns and Rose Jam", description: "Floral and vibrant organic jam", price: 35, image: "https://www.pureindianfoods.com/v/vspfiles/photos/RPP-2T.jpg", inventory: 40)

donut1 = davids.items.create(name: "Boston Cream Donut", description: "Chocolatey Creamy Deliciousness", price: 3.50, image: "https://i.pinimg.com/originals/d3/aa/54/d3aa544dbace28f05b0b2e78cc42b588.jpg", inventory: 50)
donut2 = davids.items.create(name: "Rainbow Sprinkle Donut", description: "Vanilla cake donut with sprinkles, YUM", price: 1.50, image: "https://deliciouslysprinkled.com/wp-content/uploads/2015/04/Baked-Vanilla-Donuts-blog-480x360.jpg", inventory: 50)
donut3 = davids.items.create(name: "Cookies n Cream", description: "Vanilla raised donut with oreo crumbs", price: 1.50, image: "https://images.squarespace-cdn.com/content/v1/535469cde4b02e672cf340ef/1434573972867-38JQ2WGG72FR3MV81NYZ/ke17ZwdGBToddI8pDm48kLkXF2pIyv_F2eUT9F60jBl7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0iyqMbMesKd95J-X4EagrgU9L3Sa3U8cogeb0tjXbfawd0urKshkc5MgdBeJmALQKw/P6131466.JPG?format=2500w", inventory: 50)
donut4 = davids.items.create(name: "German Chocolate Cake", description: "Chocolate donut with caramel and coconut", price: 1.50, image: "https://pbs.twimg.com/media/DBkb-anWsAA8YDm.jpg", inventory: 50)
donut5 = davids.items.create(name: "Apple Cider", description: "Apple cider donut covered in cinnamon sugar", price: 1.50, image: "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2009/8/13/1/FNM100109SugarFix004_s4x3.jpg.rend.hgtvcom.616.462.suffix/1382539087821.jpeg", inventory: 50)
donut6 = davids.items.create(name: "Beignet", description: "Fluffy fried dough pillow covered in powdered sugar", price: 1.50, image: "https://bakerbynature.com/wp-content/uploads/2017/09/beignets-1-of-1.jpg", inventory: 50)

knit1 = kats.items.create(name: "Cardigan", description: "Very cozy", price: 75.50, image: "https://gloimg.zafcdn.com/zaful/pdm-product-pic/Clothing/2019/08/23/goods-first-img/1567387669487090073.jpg", inventory: 30)
knit2 = kats.items.create(name: "Blanket", description: "The most cozy", price: 99.99, image: "https://i.pinimg.com/originals/cd/c8/fc/cdc8fc1e39f3ce75d0053c03d7d61c9f.jpg", inventory: 10)

kats.items << alpaca4
jw.items << record6
jw.items << donut5
davids.items << jam2


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

merchant_user2 = User.create(name: "Bill John",
  address: "1491 Street St",
  city: "Denver",
  state: "CO",
  zip: "801231",
  email: "billjo@mail.com",
  password: "burgers",
  password_confirmation: "burgers",
  role: 1,
  merchant: rays
)

merchant_user3 = User.create(name: "Bill John",
  address: "1491 Street St",
  city: "Denver",
  state: "CO",
  zip: "801231",
  email: "alpaca@mail.com",
  password: "burgers",
  password_confirmation: "burgers",
  role: 1,
  merchant: alpaca
)

merchant_user4 = User.create(name: "Bill John",
  address: "1491 Street St",
  city: "Denver",
  state: "CO",
  zip: "801231",
  email: "david@mail.com",
  password: "burgers",
  password_confirmation: "burgers",
  role: 1,
  merchant: davids
)

merchant_user5 = User.create(name: "Bill John",
  address: "1491 Street St",
  city: "Denver",
  state: "CO",
  zip: "801231",
  email: "jordan@mail.com",
  password: "burgers",
  password_confirmation: "burgers",
  role: 1,
  merchant: jw
)

merchant_user6 = User.create(name: "Bill John",
  address: "1491 Street St",
  city: "Denver",
  state: "CO",
  zip: "801231",
  email: "kat@mail.com",
  password: "burgers",
  password_confirmation: "burgers",
  role: 1,
  merchant: kats
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

tire.item_orders.create(quantity: 7, price: 2, order: order)


order2 = Order.create(name: "Kathleen", address: "1491 Street St", city: "Denver", state: "CO", zip: "80123", user: regular_user, status: 'pending')

jam1.item_orders.create(quantity: 2, price: 2, order: order2)
record5.item_orders.create(quantity: 4, price: 2, order: order2)
alpaca2.item_orders.create(quantity: 17, price: 2, order: order2)

order3 = Order.create(name: "Ray", address: "1491 Street St", city: "Denver", state: "CO", zip: "80123", user: regular_user, status: 'packaged')

knit2.item_orders.create(quantity: 1, price: 2, order: order3)
record4.item_orders.create(quantity: 2, price: 2, order: order3)
record3.item_orders.create(quantity: 4, price: 2, order: order3)
alpaca4.item_orders.create(quantity: 1, price: 2, order: order3)

order4 = Order.create(name: "Ray", address: "1491 Street St", city: "Denver", state: "CO", zip: "80123", user: regular_user, status: 'pending')

knit1.item_orders.create(quantity: 1, price: 2, order: order4)
record1.item_orders.create(quantity: 1, price: 2, order: order4)
record2.item_orders.create(quantity: 1, price: 2, order: order4)
record6.item_orders.create(quantity: 5, price: 2, order: order4)
alpaca1.item_orders.create(quantity: 2, price: 2, order: order4)
alpaca3.item_orders.create(quantity: 1, price: 2, order: order4)
alpaca4.item_orders.create(quantity: 3, price: 2, order: order4)
jam5.item_orders.create(quantity: 1, price: 2, order: order2)

order5 = Order.create(name: "Jordan", address: "1491 Street St", city: "Denver", state: "CO", zip: "80123", user: regular_user, status: 'pending')

jam3.item_orders.create(quantity: 1, price: 2, order: order5)
jam2.item_orders.create(quantity: 4, price: 2, order: order5)
jam1.item_orders.create(quantity: 1, price: 2, order: order5)
donut1.item_orders.create(quantity: 1, price: 2, order: order5)

order6 = Order.create(name: "David", address: "1491 Street St", city: "Denver", state: "CO", zip: "80123", user: regular_user, status: 'pending')

donut4.item_orders.create(quantity: 1, price: 2, order: order6)
donut6.item_orders.create(quantity: 2, price: 2, order: order6)
donut3.item_orders.create(quantity: 2, price: 2, order: order6)
donut2.item_orders.create(quantity: 1, price: 2, order: order6)
donut5.item_orders.create(quantity: 4, price: 2, order: order6)
donut1.item_orders.create(quantity: 1, price: 2, order: order6)

order7 = Order.create(name: "David", address: "1491 Street St", city: "Denver", state: "CO", zip: "80123", user: regular_user, status: 'cancelled')

alpaca1.item_orders.create(quantity: 1, price: 2, order: order7)
jam4.item_orders.create(quantity: 3, price: 2, order: order7)
record1.item_orders.create(quantity: 1, price: 2, order: order7)
donut2.item_orders.create(quantity: 2, price: 2, order: order7)
record3.item_orders.create(quantity: 10, price: 2, order: order7)
donut1.item_orders.create(quantity: 1, price: 2, order: order7)
