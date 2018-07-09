module ProductType

  def is_imported_item(product_order)
    return product_order.include?("imported")
  end

  def is_non_tax_item(product_order)
    return (product_order.include?("book") || product_order.include?("chocolate") || product_order.include?("chocolates") || product_order.include?("pills"))
  end

  def is_imported_and_non_taxable(product_order)
    return is_imported_item(product_order) && is_non_tax_item(product_order)
  end
  
end

class SalesProduct

  IMPORT_TAX_PERCENTAGE = 5
  BASIC_TAX_PERCENTAGE = 10
  NON_TAX_ITEM_TAX_PERCENTAGE = 0

  include ProductType

  attr_reader :shelf_price
  attr_accessor :sales_tax

  def initialize(shelf_price)
    @shelf_price = shelf_price
    @sales_tax = 0
  end

  def round_off_tax(sales_tax)
    sales_tax = sales_tax.round(2)

    last_num = (sales_tax * 100) % 10

    if last_num <= 2
        sales_tax = sales_tax.floor(1)
    elsif last_num >= 8
        sales_tax = sales_tax.ceil(1)
    else
        sales_tax = sales_tax.floor(1) + 0.05
    end

    return sales_tax.round(2)
  end

  def calculate_tax(tax_percentage)
    initial_sales_tax = (tax_percentage * self.shelf_price)/100.0
    final_sales_tax = round_off_tax(initial_sales_tax)
    self.sales_tax = final_sales_tax
  end

  def calculate_item_price
    (self.shelf_price + self.sales_tax).round(2)
  end

  def SalesProduct.calculate_total_price(all_products_array)
    total_price = 0
    all_products_array.each do |item|
        total_price += (item.shelf_price + item.sales_tax)
    end
    return total_price.round(2)
  end

  def SalesProduct.calculate_total_tax(all_products_array)
    total_tax = 0
    all_products_array.each do |item|
        total_tax += item.sales_tax
    end
    return total_tax.round(2)
  end

  def SalesProduct.calculate_result(orders, checked_out_orders)
    orders.each do |product_order|

      shelf_price = (product_order.split(" "))[-1].to_f
      item = SalesProduct.new(shelf_price)

      if item.is_imported_and_non_taxable(product_order)
        item.calculate_tax(IMPORT_TAX_PERCENTAGE)
      
      elsif item.is_imported_item(product_order)
        item.calculate_tax(BASIC_TAX_PERCENTAGE + IMPORT_TAX_PERCENTAGE)

      elsif item.is_non_tax_item(product_order)
        item.calculate_tax(NON_TAX_ITEM_TAX_PERCENTAGE)

      else
        item.calculate_tax(BASIC_TAX_PERCENTAGE)
      end

      checked_out_orders.push(item)

    end

    return checked_out_orders
  end

end

for i in 1..3
    
  orders = Array.new
  checked_out_orders = Array.new

  puts "Input #{i}:"
  while(true)
    product_order = gets.chomp
    if product_order == ""
        break
    else
        orders.push(product_order)
    end
  end

  checked_out_orders = SalesProduct.calculate_result(orders, checked_out_orders)

  puts "Output #{i}:"
  for i in 1..orders.length
    print "#{orders[i-1].slice(0, orders[i-1].length - 8)}: #{checked_out_orders[i-1].calculate_item_price}\n"
  end

  puts "Sales Tax: #{SalesProduct.calculate_total_tax(checked_out_orders)}"
  puts "Total: #{SalesProduct.calculate_total_price(checked_out_orders)}\n\n"
    
end