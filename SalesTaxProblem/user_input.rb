module UserInput
  def self.get_orders
    orders = []
    puts 'Input :'
    while true
      order_item = gets.chomp
      break if order_item == ''
      unless order_item.split(' ')[0].integer?
        puts 'Enter an integer as quantity: '
        redo
      end
      unless order_item.split(' ')[-1].numeric?
        puts 'Enter a numeric value as the shelf price: '
        redo
      end
      orders.push(order_item)
    end
    orders
  end
end

class String
  def numeric?
    !Float(self).nil? rescue false
  end

  def integer?
    !Integer(self).nil? rescue false
  end
end
