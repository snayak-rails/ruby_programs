arr1 = Array['a','b','c','a','d','b','c','c']
puts "#{arr1}"

freq_hash = Hash.new("NA")

arr1.each do |item|
    if freq_hash[item] == "NA"
        freq_hash[item] = 1
    else
        freq_hash[item] += 1
    end
end

freq_hash.each do |key, value|
    puts "#{key} : #{value}"
end