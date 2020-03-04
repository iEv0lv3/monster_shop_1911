class Admin::MerchantItemsController < Admin::BaseController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    merchant = Merchant.find(params[:id])
    @item = merchant.items.create(item_params)
  end

  def create
    merchant = Merchant.find(params[:id])
    params.delete :image if params[:image].blank?
    @item = merchant.items.create(item_params)
    if @item.save
      flash[:success] = "#{@item.name} has been saved."
      redirect_to "/admin/merchants/#{merchant.id}/items"
    else
      flash.now[:error] = @item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    merchant = @item.merchant
    if @item.update(item_params)
      flash[:success] = "#{@item.name} has been updated."
      redirect_to "/admin/merchants/#{merchant.id}/items"
    else
      flash.now[:error] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    item = Item.find_by(id: params[:id])
    if !item
      flash[:error] = "Item already deleted."
    elsif item.no_orders?
      flash[:success] = "'#{item.name}' has been deleted."
      item.destroy
    else
      flash[:error] = "Cannot delete an item with orders."
    end
    redirect_to "/admin/merchants"
  end

    private

    def item_params
      params.permit(:name,:description,:price,:inventory,:image)
    end
end
