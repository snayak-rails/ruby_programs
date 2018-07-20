input = Array['a','b','c','a','d','b','c','c']
puts "#{input}"

char_count = Hash.new("NA")

input.each do |character|
    if char_count[character] == "NA"
        char_count[character] = 1
    else
        char_count[character] += 1
    end
end

char_count.each do |character, count|
    puts "#{character} : #{count}"
end