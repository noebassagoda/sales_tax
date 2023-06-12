class Item
  attr_reader :name, :price, :sales_tax, :price_with_tax, :imported, :container_type

  SALES_TAX = 0.10    #Sales tax rate: 10%
  IMPORT_TAX = 0.05   #Import tax rate: 5%
  
  EXEMPT_BOOKS = ['book', 'books'] 
  EXEMPT_FOOD = ['chocolate', 'chocolates', 'chocolate bar']
  EXEMPT_MEDICAL = ['headache pills']
  EXEMPT_ITEMS = EXEMPT_BOOKS + EXEMPT_FOOD + EXEMPT_MEDICAL

  def initialize(name:, price:, imported: false, container_type: nil)
    @name = name
    @price = price
    @imported = imported
    @container_type = container_type

    @sales_tax = calculate_sales_tax
    @price_with_tax = @price + @sales_tax
  end

  def to_s
    item_details = @imported ? "imported " : ""
    item_details += "#{@container_type} of " if @container_type
    item_details += "#{@name}"

    item_details
  end

  private

  def calculate_sales_tax
    tax_total = basic_sales_tax + import_tax
    
    #Round up to the nearest 0.05 (0.05 = 1/20)
    (tax_total * 20).ceil / 20.0  
  end

  def basic_sales_tax
    return 0.0 if exempted?

    @price * SALES_TAX
  end

  def import_tax
    return 0.0 unless @imported
    
    @price * IMPORT_TAX
  end

  def exempted?
    EXEMPT_ITEMS.include?(@name)
  end
end