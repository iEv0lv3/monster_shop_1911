class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    item.price * @contents[item.id.to_s]
  end

  def total
    @contents.sum do |item_id,quantity|
      Item.find(item_id).price * quantity
    end
  end

  def edit_quantity(params)
    item = Item.find(params[:item_id].to_i)
    if params[:value] == "add"
      contents[params[:item_id]] += 1 unless inventory_limit?("max", item)
    elsif params[:value] == "sub"
      contents[params[:item_id]] -= 1
      return 0 if inventory_limit?("min", item)
    end
  end

  def inventory_limit?(level, item)
    if level == "max"
      item.inventory == contents[item.id.to_s]
    elsif level == "min"
      contents[item.id.to_s] == 0
    end
  end

  def discount_check
    items.reduce(Hash.new(0)) do |discount, item|
      best_discount = Discount.where("discounts.merchant_id = #{item[0].merchant_id} AND #{item[1]} >= discounts.item_count")
                              .order(percent: :desc)
                              .limit(1)

      discount[item[0]] = best_discount[0] unless best_discount.empty?
      discount
    end
  end
end
