# module Invoice : prints bill for a group of orders
module Invoice
  def print_invoice(orders)
    puts 'Output :'
    orders.each do |item|
      item_price = ((item[:shelf_price] + item[:sales_tax]) *
                    item[:quantity]).round(2)
      puts "#{item[:description]} : #{item_price}"
    end
    total_tax = calculate_total_tax(orders)
    puts "Sales Tax: #{total_tax}"
    total_price = calculate_total_price(orders)
    puts "Total: #{total_price}\n\n"
  end

  def calculate_total_price(orders)
    total_price = 0
    orders.each do |item|
      total_price += (item[:shelf_price] + item[:sales_tax])
    end
    total_price.round(2)
  end

  def calculate_total_tax(orders)
    total_tax = 0
    orders.each do |item|
      total_tax += item[:sales_tax]
    end
    total_tax.round(2)
  end
end
