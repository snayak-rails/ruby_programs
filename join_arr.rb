input1 = Array[1,2,3,4,5]
input2 = Array[6,7,8,9,10]

input2.each do |element|
    input1 << element
end

puts "#{input1}"