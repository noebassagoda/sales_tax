require_relative '../receipt'

RSpec.describe 'Main' do
  describe 'receipt generation' do
    context 'when the receipt has valid input' do
      let(:input_filename) { 'input.txt' }
      let(:input_lines) do
        [
          '1 imported bottle of perfume at 27.99',
          '1 bottle of perfume at 18.99',
          '1 packet of headache pills at 9.75',
          '3 imported boxes of chocolates at 11.25'
        ]
      end
      let(:expected_output) do
        <<~OUTPUT
          1 imported bottle of perfume: 32.19
          1 bottle of perfume: 20.89
          1 packet of headache pills: 9.75
          3 imported boxes of chocolates: 35.55
          Sales Taxes: 7.90
          Total: 98.38
        OUTPUT
      end

      it 'generates a receipt with correct totals' do
        allow(File).to receive(:readlines).with("input/#{input_filename}", chomp: true).and_return(input_lines)

        RSpec::Mocks.with_temporary_scope do
          ARGV[0] = input_filename
          expect do
            load('../main.rb')
          end.to output(expected_output).to_stdout
        end
      end
    end

    context 'when the receipt has invalid input' do
      context 'when the input file does not exist' do
        let(:input_filename) { 'invalid_input.txt' }

        it 'outputs an error message for file not found' do
          allow(File).to receive(:readlines).with("input/#{input_filename}", chomp: true).and_raise(Errno::ENOENT)

          RSpec::Mocks.with_temporary_scope do
            ARGV[0] = input_filename
            expect do
              load('../main.rb')
            end.to output("Input file not found: invalid_input.txt\n").to_stdout.and raise_error(SystemExit, /exit/)
          end
        end
      end

      context 'when the input does not match the expected format' do
        let(:input_lines) { ['input line that doesnt match'] }
        let(:input_filename) { 'input.txt' }

        it 'outputs an error message for invalid input line' do
          allow(File).to receive(:readlines).with("input/#{input_filename}",
                                                  chomp: true).and_return(input_lines)

          RSpec::Mocks.with_temporary_scope do
            ARGV[0] = input_filename
            expect do
              load('../main.rb')
            end.to output("Invalid input line: input line that doesnt match\n").to_stdout.and raise_error(SystemExit, /exit/)
          end
        end
      end
    end
  end
end
