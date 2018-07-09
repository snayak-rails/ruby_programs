#!/usr/bin/ruby -w

arr = []

while(true)
    x = gets.chomp
    if x == ""
        break
    else
        arr.push(x)
    end
end

puts "#{arr}"