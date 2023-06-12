require_relative 'item'

class LineItem
  attr_reader :item, :quantity, :total_amount, :total_sales_tax

  def initialize(item, quantity = 1)
    @item = item
    @quantity = quantity
    @total_amount = @item.price_with_tax * quantity
    @total_sales_tax = @item.sales_tax * quantity
  end

  def to_s
    "#{@quantity} #{@item.to_s}: #{format('%.2f', @total_amount)}"
  end
end
