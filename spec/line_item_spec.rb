require_relative '../line_item'

RSpec.describe LineItem do
  let(:item) { Item.new(name: 'perfume', price: 27.99, imported: true, container_type: 'bottle') }
  let(:line_item) { LineItem.new(item, 2) }

  describe '#initialize' do
    it 'sets the attributes correctly' do
      expect(line_item.item).to eq(item)
      expect(line_item.quantity).to eq(2)
    end

    it 'calculates the correct total amount and total sales tax' do
      expect(line_item.total_amount).to eq(64.38)
      expect(line_item.total_sales_tax).to eq(8.40)
    end
  end

  describe '#to_s' do
    it 'returns a formatted string representation of the line item' do
      expect(line_item.to_s).to eq('2 imported bottle of perfume: 64.38')
    end
  end
end
