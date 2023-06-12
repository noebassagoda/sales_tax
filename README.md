# Sales Tax Calculator

This is a command-line application that calculates the receipt details for shopping baskets based on the given inputs. It applies basic sales tax and import duty as per the provided rules and generates the total cost of items, along with the amount of sales taxes paid.

## Requirements

- Ruby
- Rspec

## Getting Started

To run the application, follow the steps below:

1. Clone the repository:
   ```
   git clone <repository_url>
   ```

2. Navigate to the project directory:
   ```
   cd sales-tax
   ```

3. Run the application with the provided input examples:
     ```
     ruby sales_tax_.rb input/<filename>.txt
     ```

## Assumptions

- The input format for items is as follows: `<quantity> [imported] [container type] <name> at <price>`. For example, `2 book at 12.49` or `1 imported bottle of perfume at 27.99`.
- If the input does not match the specified format, an error message will be printed, and the program will exit.
- If the provided input filename does not match any existing file, an error message will be printed, and the program will exit.
- The rounding rules for sales tax are as follows: for a tax rate of n%, a shelf price of p contains `(np/100 rounded up to the nearest 0.05)` amount of sales tax.

## Output

The application will print out the receipt details for each shopping basket.

- The receipt details include the name of each item and its price (including tax).
- The sales taxes paid and the total cost of the items are displayed at the end.

## Example
### Input 1:
```
2 boxes of book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85
```

Output 1:
```
2 boxes of book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

### Input 2:
```
1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50
```

Output 2:
```
1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15
```

### Input 3:
```
1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
3 imported boxes of chocolates at 11.25
```

Output 3:
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

## Running Tests

The application includes tests to ensure its correctness and robustness. To run the tests, follow the instructions below:

1. Make sure you have RSpec installed. If not, you can install it by running:
     ```
     gem install rspec
     ```

2. Navigate to the tests folder within the project directory:
   ```
   cd sales-tax/spec
   ```

3. Once you're in the corresponding folder, run the tests:
     ```
     rspec .
     ```

The tests will validate the functionality of the application, including the calculations, input parsing, and edge case handling.

## Notes

The solution provided in this repository is complete and has been tested against the supplied test data. It accurately calculates the receipt details, including the correct sales taxes and total cost of the items for each shopping basket. Additionally, the solution handles various edge cases to ensure robustness. For example, it accounts for scenarios where the input file does not exist, providing appropriate error messages to the user. It also validates the format of the input data and handles cases where the input does not match the specified format, ensuring that the application does not break or produce unexpected results.
