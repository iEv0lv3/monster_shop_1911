# Monster Shop - Turing Back End Engineering, Module 2, Group Project<br>
## Heroku App: https://monster-shop-dreamteam.herokuapp.com/
## Schema Design: https://dbdiagram.io/d/5e4c68d49e76504e0ef19d9d

## Jordan Williams Github: https://github.com/iEv0lv3
## David Atkins Github: https://github.com/d-atkins
## Kathleen Carroll Github: https://github.com/kathleen-carroll
## Raymond Nguyen Github:https://github.com/itemniner
# Monster Shop
Students will be put into 3 or 4 person groups to complete the project.\n


Implementation instructions:

### Overview:
Monster Shop is a mock-up ecommerce website that allows you to browse through merchants and their items. This website explores admin, merchant, user and visitor UI and access.

As a visitor, you can visit the app and explore merchants, merchant items and add items to your cart. Then you must register to checkout.

As a user, you are generated a profile with the given email and password and your information is saved in the user database. Your information can be edited at anytime. You now have access to checkout out items in your cart, view orders or continue shopping.

As a merchant employee, you are generated a dashboard in which you can see the merchant you are employed to and your user information which you can edit at anytime. You now have access to fulfill orders, create items, delete items, and view orders placed by your merchant.

As an administrator, you are generated a admin dashboard

BE Mod 2 Week 4/5 Group Project

### Getting Started
1. Fork this repository
2. Clone down your forked repository
3. From your repository's root directory, run:
`bundle install`
4. Set up the database
`rake db:{drop,create,migrate,seed}`

### Merchants
Merchants are stores that carry items.
- can be activated/deactivated by administrator



### Items
Items belong to merchants, and can be added to the cart.
- Items can be deactivated by merchant employees and admins
  - deactivated items will not show up in the items index


### Users
There are four kinds of users:
- Visitors
- Regular users
- Merchant employees
- Administrator

### Orders
Orders can be made by regular users and merchant users when items are added to the cart.
Visitors can add items to the cart but must log in to make an order.

Orders have four possible statuses:
- pending: default status
- packaged: all merchants have fulfilled all items on the order
- shipped: admin has approved shipping of order
- canceled: user cancels a pending or packaged order
