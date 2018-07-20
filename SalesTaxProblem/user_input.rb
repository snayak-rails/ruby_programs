module UserInput

def get_orders
  orders = []
  puts "Input #{count}:"
  while (true)
    order_item = gets.chomp
    break if order_item.nil?
    orders.push(order_item)
  end
  orders
end
