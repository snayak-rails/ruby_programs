# module UserInput : helper methods for getting user input and validation
module UserInput
  def read_input_from_user
    order_list = []
    puts 'Enter X to end input'
    puts 'Input :'
    until (order_item = gets.chomp) == 'X'
      order_item = check_order_quantity_integer?(order_item)
      order_item = check_order_price_numeric?(order_item)
      order_item = check_order_description?(order_item)
      order_list.push(order_item)
    end
    order_list
  end

  def check_order_quantity_integer?(order_item)
    until order_item.split(' ')[0].integer?
      puts 'Enter an integer as quantity: '
      order_item = gets.chomp
    end
    order_item
  end

  def check_order_price_numeric?(order_item)
    until order_item.split(' ')[-1].numeric?
      puts 'Enter a numeric value as the shelf price: '
      order_item = gets.chomp
    end
    order_item
  end

  def check_order_description?(order_item)
    until /\d+ [\w\s]+at/.match(order_item.split(' ')[0...-1].join(' '))
      puts 'Enter proper order description: '
      order_item = gets.chomp
    end
    order_item
  end
end

# override string class for checking integer and numeric user inputs
class String
  def numeric?
    !Float(self).nil? rescue false
  end

  def integer?
    !Integer(self).nil? rescue false
  end
end
