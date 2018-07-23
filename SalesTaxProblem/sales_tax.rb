require_relative 'product_type'
require_relative 'invoice'
require_relative 'user_input'

class SalesTax
  include ProductType
  include Invoice
  include UserInput

  IMPORT_TAX_PERCENTAGE = 5
  BASIC_TAX_PERCENTAGE = 10
  NON_TAX_ITEM_TAX_PERCENTAGE = 0

  attr_reader :shelf_price, :item_description, :quantity
  attr_accessor :sales_tax

  def initialize(order_item)
    @shelf_price = order_item.split(' ')[-1].to_f
    @item_description = order_item.split(' at ')[0]
    @quantity = order_item.split(' ')[0].to_i
    @sales_tax
  end

  def round_two_precision5(sales_tax)
    (sales_tax * 20.0).round / 20.0
  end

  def calculate_tax_percentage
    if imported_and_non_tax_item?
      IMPORT_TAX_PERCENTAGE + NON_TAX_ITEM_TAX_PERCENTAGE
    elsif imported_item?
      BASIC_TAX_PERCENTAGE + IMPORT_TAX_PERCENTAGE
    elsif non_tax_item?
      NON_TAX_ITEM_TAX_PERCENTAGE
    else
      BASIC_TAX_PERCENTAGE
    end
  end

  def calculate_tax(tax_percentage)
    initial_sales_tax = (@quantity * tax_percentage * @shelf_price) / 100.0
    final_sales_tax = round_two_precision5(initial_sales_tax)
    @sales_tax = final_sales_tax
  end

  def self.calculate_result
    orders = []
    unformatted_orders = UserInput.get_orders
    unformatted_orders.each do |order_item|
      item = SalesTax.new(order_item)
      tax_percentage = item.calculate_tax_percentage
      item.calculate_tax(tax_percentage)
      orders.push(item)
    end
    Invoice.print_invoice(orders)
  end
end

3.times do
  SalesTax.calculate_result
end
