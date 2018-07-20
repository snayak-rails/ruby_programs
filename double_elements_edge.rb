input = [1,2,3,'a','b',4,5]

input_doubled = input.map {|elem| (elem.is_a? Numeric) ? elem*2 : "not_a_number"}

puts "#{input_doubled}"