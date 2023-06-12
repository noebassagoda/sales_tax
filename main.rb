require_relative 'item'
require_relative 'receipt'

begin
  # Read the command-line argument - input file name
  input_filename = ARGV[0]

  # Read the input file
  lines = File.readlines("input/#{input_filename}", chomp: true)

  receipt = Receipt.new

  # Add each line item to the receipt
  lines.each do |line|
    # Parse the line to extract item details
    match_data = /^(\d+)\s(?:imported\s)?(box(?:es)?|packet|bottle)?(?:\sof\s)?(.*?)\sat\s(\d+\.\d{2})$/.match(line)

    if match_data.nil?
      # Handle case when the regular expression does not match the input line
      puts "Invalid input line: #{line}"
      exit(1)
    end

    quantity = match_data[1].to_i
    imported = line.include?('imported')
    container_type = match_data[2]&.strip
    name = match_data[3].strip
    price = match_data[4].to_f

    item = Item.new(name: name, price: price, imported: imported, container_type: container_type)
  
    receipt.create_line_item(item, quantity)
  end

  puts receipt.to_s

rescue Errno::ENOENT => e
  # Handle case when the input file does not exist
  puts "Input file not found: #{input_filename}"
  exit(1) 
end
