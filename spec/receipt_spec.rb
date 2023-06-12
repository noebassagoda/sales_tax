require_relative '../receipt'

RSpec.describe Receipt do
  let(:receipt) { Receipt.new }

  describe '#create_line_item' do
    let(:item) { Item.new(name: 'book', price: 9.99) }

    it 'creates a line item from the given item' do
      receipt.create_line_item(item)

      expect(receipt.line_items.count).to eq(1)
      expect(receipt.line_items.first.item).to eq(item)
    end
  end

  describe '#to_s' do
    let(:item_exempted_tax) { Item.new(name: 'book', price: 9.99) }
    let(:item_basic_sales_tax) { Item.new(name: 'music CD', price: 14.99) }
    let(:item_imported) { Item.new(name: 'chocolates', price: 10.00, imported: true, container_type: 'box') }

    context 'when there are no line items' do
      it 'returns a message indicating there are no items in the receipt' do
        expect(receipt.to_s).to eq('No items in the receipt')
      end
    end

    context 'when given item with exempted tax' do
      let(:expected_output) do
        <<~OUTPUT.strip
          1 book: 9.99
          Sales Taxes: 0.00
          Total: 9.99
        OUTPUT
      end

      it 'calculates the correct total cost and sales taxes' do
        receipt.create_line_item(item_exempted_tax)

        expect(receipt.to_s).to eq(expected_output)
      end
    end

    context 'when given item with basic sales tax' do
      let(:expected_output) do
        <<~OUTPUT.strip
          1 music CD: 16.49
          Sales Taxes: 1.50
          Total: 16.49
        OUTPUT
      end

      it 'calculates the correct total cost and sales taxes' do
        receipt.create_line_item(item_basic_sales_tax)

        expect(receipt.to_s).to eq(expected_output)
      end
    end

    context 'when given imported items' do
      let(:expected_output) do
        <<~OUTPUT.strip
          1 imported box of chocolates: 10.50
          Sales Taxes: 0.50
          Total: 10.50
        OUTPUT
      end

      it 'calculates the correct total cost and sales taxes' do
        receipt.create_line_item(item_imported)

        expect(receipt.to_s).to eq(expected_output)
      end
    end

    context 'when given a mixture of exempt, taxable, and imported items' do
      let(:expected_output) do
        <<~OUTPUT.strip
          1 book: 9.99
          1 music CD: 16.49
          1 imported box of chocolates: 10.50
          Sales Taxes: 2.00
          Total: 36.98
        OUTPUT
      end

      it 'calculates the correct total cost and sales taxes' do
        receipt.create_line_item(item_exempted_tax)
        receipt.create_line_item(item_basic_sales_tax)
        receipt.create_line_item(item_imported)

        expect(receipt.to_s).to eq(expected_output)
      end
    end
  end
end
