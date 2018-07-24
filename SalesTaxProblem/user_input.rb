# module UserInput : helper methods for getting user input and validation
module UserInput
  def read_input_from_user
    order_list = []
    puts 'Enter X to end input'
    puts 'Input :'
    begin
      until (order_item = gets.chomp) == 'X'
        validate_user_input(order_item)
        order_list.push(order_item)
      end
    rescue StandardError => e
      puts e.message
      retry
    end
    order_list
  end

  def validate_user_input(order_item)
    check_order_quantity?(order_item)
    check_order_price?(order_item)
    check_order_description?(order_item)
  end

  def check_order_quantity?(order_item)
    quantity = order_item.split(' ')[0]
    error_message = 'Please enter an integer greater than 0 as the quantity: '
    raise error_message unless quantity.integer? && quantity.to_i > 0
  end

  def check_order_price?(order_item)
    shelf_price = order_item.split(' ')[-1]
    error_message = 'Please enter a number greater than 0.0 as the shelf_price: '
    raise error_message unless shelf_price.numeric? && shelf_price.to_f > 0.0
  end

  def check_order_description?(order_item)
    description = order_item.split(' ')[0...-1].join(' ')
    error_message = 'Enter proper order description: '
    raise error_message unless /\d+ [\w\s]+at/.match(description)
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
