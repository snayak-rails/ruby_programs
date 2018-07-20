require_relative 'product_type'
require_relative 'invoice'
require_relative 'user_input'

class SalesTax
  include ProductType, Invoice, Userinput

  IMPORT_TAX_PERCENTAGE = 5
  BASIC_TAX_PERCENTAGE = 10
  NON_TAX_ITEM_TAX_PERCENTAGE = 0

  attr_reader :shelf_price
  attr_accessor :sales_tax

  def initialize(shelf_price, item_quantity)
    @shelf_price = shelf_price
    @sales_tax = 0
    @quantity = item_quantity
  end

  def round_off_tax(sales_tax)
    sales_tax = sales_tax.round(2)
    last_num = (sales_tax * 100) % 10
    return sales_tax = sales_tax.floor(1).round(2) if last_num <= 2
    return sales_tax = sales_tax.ceil(1).round(2) if last_num >= 8
    (sales_tax.floor(1) + 0.05).round(2)
  end

  def calculate_tax_percentage(item, order_item)
    if item.imported_and_non_tax_item?(order_item)
      return IMPORT_TAX_PERCENTAGE + NON_TAX_ITEM_TAX_PERCENTAGE
    elsif item.imported_item?(order_item)
      return BASIC_TAX_PERCENTAGE + IMPORT_TAX_PERCENTAGE
    elsif item.non_tax_item?(order_item)
      return NON_TAX_ITEM_TAX_PERCENTAGE
    else
      BASIC_TAX_PERCENTAGE
    end
  end

  def calculate_tax(tax_percentage)
    initial_sales_tax = (@quantity * tax_percentage * @shelf_price)/100.0
    final_sales_tax = round_off_tax(initial_sales_tax)
    @sales_tax = final_sales_tax
  end

  def self.calculate_result(orders)
    checked_out_orders = []

    orders.each do |order_item|
      shelf_price = order_item.split(' ')[-1].to_f
      item_quantity = order_item.split(' ')[0].to_f
      item = SalesTax.new(shelf_price, item_quantity)
      tax_percentage = calculate_tax_percentage(item, order_item)
      item.calculate_tax(tax_percentage)
      checked_out_orders.push(item)
    end
    checked_out_orders
  end
end

3.times do
  orders = UserInput.get_orders
  checked_out_orders = SalesTax.calculate_result(orders)
  Invoice.print_invoice(orders, checked_out_orders)
end
