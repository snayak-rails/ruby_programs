class String

    def numeric?
        Float(self) != nil rescue false
    end

end

arr = Array.new
while ((x = gets.chomp) != "")

    arr.push(x.split(" "))

end

arr.map do |i|

    #if i.numeric?
    #    i = "yes"
    #else
    #    i = "no"
    #end
    puts "#{i.class}"
end

puts "#{arr}"