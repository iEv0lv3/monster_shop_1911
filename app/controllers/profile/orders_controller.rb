class Profile::OrdersController < Profile::BaseController
  def index
    @user = current_user
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
  end

  def create
    order = current_user.orders.create(order_params)
    discounts = cart.discount_check
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price_check(discounts)
        })
      end
      session.delete(:cart)
      flash[:success] = "Your order was created."
      redirect_to "/profile/orders"
    else
      flash[:error] = "Please complete address form to create an order."
      render :new
    end
  end

  def update
    order = Order.find(params[:id])

    if order.pending? || order.packaged?
      order.cancel
      flash[:success] = 'Order cancelled'
    else
      flash[:error] = "Unable to cancel an order that is already #{order.status}"
    end

    redirect_to profile_path
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
