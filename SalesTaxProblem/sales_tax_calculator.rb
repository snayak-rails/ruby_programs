require_relative 'product_type'
require_relative 'invoice'
require_relative 'user_input'

# SalesTax : Sales tax calculation for a group of orders
class SalesTaxCalculator
  include ProductType
  include Invoice
  include UserInput

  IMPORT_TAX_PERCENTAGE = 5
  BASIC_TAX_PERCENTAGE = 10
  NON_TAX_ITEM_TAX_PERCENTAGE = 0

  def build_item_hash(order_item)
    quantity = order_item.split(' ')[0].to_i
    shelf_price = order_item.split(' ')[-1].to_f
    description = order_item.split(' at ')[0]
    Hash['quantity': quantity, 'shelf_price': shelf_price,
         'description': description, 'sales_tax': 0]
  end

  def round_two_precision5(sales_tax)
    (sales_tax * 20.0).round / 20.0
  end

  def calculate_tax_percentage(item_description)
    if imported_and_non_tax_item?(item_description)
      IMPORT_TAX_PERCENTAGE + NON_TAX_ITEM_TAX_PERCENTAGE
    elsif imported_item?(item_description)
      BASIC_TAX_PERCENTAGE + IMPORT_TAX_PERCENTAGE
    elsif non_tax_item?(item_description)
      NON_TAX_ITEM_TAX_PERCENTAGE
    else
      BASIC_TAX_PERCENTAGE
    end
  end

  def calculate_tax(item)
    tax_percentage = calculate_tax_percentage(item[:description])
    quantity = item[:quantity]
    shelf_price = item[:shelf_price]
    initial_sales_tax = (quantity * tax_percentage * shelf_price) / 100.0
    final_sales_tax = round_two_precision5(initial_sales_tax)
    item[:sales_tax] = final_sales_tax
  end

  def start_calculator
    orders = []
    order_list = read_input_from_user
    order_list.each do |order_item|
      item = build_item_hash(order_item)
      calculate_tax(item)
      orders.push(item)
    end
    print_invoice(orders)
  end
end

3.times do
  sales_tax_calculator = SalesTaxCalculator.new
  sales_tax_calculator.start_calculator
end
