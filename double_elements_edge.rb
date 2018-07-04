arr1 = [1,2,3,'a','b',4,5]

x = arr1.map {|elem| (elem.is_a? Numeric) ? elem*2 : "not_a_number"}

puts "#{x}"