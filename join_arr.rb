arr1 = Array[1,2,3,4,5]
arr2 = Array[6,7,8,9,10]

arr2.each do |i|
    arr1 << i
end

puts "#{arr1}"