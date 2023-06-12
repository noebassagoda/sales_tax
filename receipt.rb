require_relative 'item'
require_relative 'line_item'

class Receipt
  attr_reader :line_items, :total_sales_tax, :total_price
  
  def initialize
    @line_items = []
    @total_sales_tax = 0.0
    @total_price = 0.0
  end

  def create_line_item(item, quantity = 1)
    line_item = LineItem.new(item, quantity)
    @line_items << line_item

    @total_sales_tax += line_item.total_sales_tax
    @total_price += line_item.total_amount
  end

  def to_s
    return "No items in the receipt" if @line_items.empty?

    receipt_details = @line_items.map { |line_item| line_item.to_s }.join("\n")
    receipt_details += "\nSales Taxes: #{sprintf('%.2f', total_sales_tax)}"
    receipt_details += "\nTotal: #{sprintf('%.2f', total_price)}"
  
    receipt_details
  end
end