module ProductType

  NON_TAX_ITEMS = ["book", "books", "chocolate", "chocolates", "pill", "pills"]

  def is_imported_item(order_item)
    return order_item.include?("imported")
  end

  def is_non_tax_item(order_item)
    NON_TAX_ITEMS.each do |item|
      if order_item.include?(item)
        return true
      end
    end
    return false
  end

  def is_imported_and_non_tax_item(order_item)
    return is_imported_item(order_item) && is_non_tax_item(order_item)
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

  def calculate_tax(item_quantity, tax_percentage)
    initial_sales_tax = (item_quantity * tax_percentage * self.shelf_price)/100.0
    final_sales_tax = round_off_tax(initial_sales_tax)
    self.sales_tax = final_sales_tax
  end

  def calculate_item_price
    (self.shelf_price + self.sales_tax).round(2)
  end

  def SalesProduct.calculate_total_price(checked_out_orders)
    total_price = 0
    checked_out_orders.each do |item|
        total_price += (item.shelf_price + item.sales_tax)
    end
    return total_price.round(2)
  end

  def SalesProduct.calculate_total_tax(checked_out_orders)
    total_tax = 0
    checked_out_orders.each do |item|
        total_tax += item.sales_tax
    end
    return total_tax.round(2)
  end

  def SalesProduct.calculate_result(orders)
    checked_out_orders = Array.new

    orders.each do |order_item|
      
      shelf_price = (order_item.split(" "))[-1].to_f
      item = SalesProduct.new(shelf_price)

      item_quantity = (order_item.split(" "))[0].to_f

      if item.is_imported_and_non_tax_item(order_item)
        tax_percentage = IMPORT_TAX_PERCENTAGE + NON_TAX_ITEM_TAX_PERCENTAGE
        item.calculate_tax(item_quantity, tax_percentage)
      
      elsif item.is_imported_item(order_item)
        tax_percentage = BASIC_TAX_PERCENTAGE + IMPORT_TAX_PERCENTAGE
        item.calculate_tax(item_quantity, tax_percentage)

      elsif item.is_non_tax_item(order_item)
        tax_percentage = NON_TAX_ITEM_TAX_PERCENTAGE
        item.calculate_tax(item_quantity, tax_percentage)

      else
        tax_percentage = BASIC_TAX_PERCENTAGE
        item.calculate_tax(item_quantity, tax_percentage)
      end

      checked_out_orders.push(item)

    end

    return checked_out_orders
  end

end

for i in 1..3
    
  orders = Array.new

  puts "Input #{i}:"
  while(true)
    order_item = gets.chomp
    if order_item == ""
        break
    else
        orders.push(order_item)
    end
  end

  checked_out_orders = SalesProduct.calculate_result(orders)

  puts "Output #{i}:"
  for i in 1..orders.length
    print "#{orders[i-1].split("at")[0]}: #{checked_out_orders[i-1].calculate_item_price}\n"
  end

  puts "Sales Tax: #{SalesProduct.calculate_total_tax(checked_out_orders)}"
  puts "Total: #{SalesProduct.calculate_total_price(checked_out_orders)}\n\n"
    
end
