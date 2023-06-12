require_relative '../item'

RSpec.describe Item do
  describe '#initialize' do
    context 'when setting the items attributes' do
      let(:item) { Item.new(name: 'perfume', price: 27.99, imported: true, container_type: 'bottle') }

      it 'sets the attributes correctly' do
        expect(item.name).to eq('perfume')
        expect(item.price).to eq(27.99)
        expect(item.imported).to eq(true)
        expect(item.container_type).to eq('bottle')
      end
    end

    context 'when calculating sales tax and price with tax' do
      context 'when the item is exempted from tax' do
        let(:item) { Item.new(name: name, price: 12.99, container_type: container_type) }

        shared_examples 'item with zero sales tax' do
          it 'sets sales tax to zero and price with tax is equal to price' do
            expect(item.sales_tax).to eq(0.0)
            expect(item.price_with_tax).to eq(12.99)
          end
        end

        context 'when belongs to the book category' do
          let(:name) { 'book' }
          let(:container_type) { nil }

          include_examples 'item with zero sales tax'
        end

        context 'when belongs to the food category' do
          let(:name) { 'chocolate' }
          let(:container_type) { 'box' }

          include_examples 'item with zero sales tax'
        end

        context 'when belongs to the medical products category' do
          let(:name) { 'headache pills' }
          let(:container_type) { 'packet' }

          include_examples 'item with zero sales tax'
        end
      end

      context 'when the item is imported' do
        let(:item) { Item.new(name: 'perfume', price: 27.99, imported: true, container_type: 'bottle') }

        it 'calculates the correct sales tax and price with tax' do
          expect(item.sales_tax).to eq(4.20)
          expect(item.price_with_tax).to eq(32.19)
        end
      end

      context 'when the item is not imported' do
        let(:item) { Item.new(name: 'perfume', price: 27.99, container_type: 'bottle') }

        it 'calculates the correct sales tax and price with tax' do
          expect(item.sales_tax).to eq(2.80)
          expect(item.price_with_tax).to eq(30.79)
        end
      end
    end
  end

  describe '#to_s' do
    context 'when the item is not imported' do
      context 'when the item does not have a container type' do
        let(:item) { Item.new(name: 'book', price: 0.85) }

        it 'returns the correct string representation of the item' do
          expect(item.to_s).to eq('book')
        end
      end

      context 'when the item has a container type' do
        let(:item) { Item.new(name: 'perfume', price: 1.99, container_type: 'bottle') }

        it 'returns the correct string representation of the item' do
          expect(item.to_s).to eq('bottle of perfume')
        end
      end
    end

    context 'when the item is imported' do
      context 'when the item does not have a container type' do
        let(:item) { Item.new(name: 'book', price: 2.50, imported: true) }

        it 'returns the correct string representation of the item' do
          expect(item.to_s).to eq('imported book')
        end
      end

      context 'when the item has a container type' do
        let(:item) { Item.new(name: 'perfume', price: 49.99, imported: true, container_type: 'bottle') }

        it 'returns the correct string representation of the item' do
          expect(item.to_s).to eq('imported bottle of perfume')
        end
      end
    end
  end
end
