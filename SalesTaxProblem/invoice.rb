module Invoice

def print_invoice(orders, checked_out_orders)
  puts "Output #{count}:"
  orders.zip(checked_out_orders).each do |order, checked_out_order|
    item_description = order.split(' at ')[0]
    item_price = calculate_item_price(checked_out_order)
    puts "#{item_description}: #{item_price}"
  end
  total_tax = calculate_total_tax(checked_out_orders)
  puts "Sales Tax: #{total_tax}"
  total_price = calculate_total_price(checked_out_orders)
  puts "Total: #{total_price}\n\n"
end

def calculate_total_price(checked_out_orders)
  total_price = 0
  checked_out_orders.each do |item|
    total_price += (item.shelf_price + item.sales_tax)
  end
  total_price.round(2)
end

def calculate_total_tax(checked_out_orders)
  total_tax = 0
  checked_out_orders.each do |item|
    total_tax += item.sales_tax
  end
  total_tax.round(2)
end

def calculate_item_price(checked_out_order)
  (checked_out_order.shelf_price + checked_out_order.sales_tax).round(2)
end
