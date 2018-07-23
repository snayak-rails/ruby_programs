module UserInput
  def self.get_orders
    orders = []
    puts "Input :"
    while true
      order_item = gets.chomp
      break if order_item == ""
      orders.push(order_item)
    end
    orders
  end
end
