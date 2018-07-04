require "csv"

x = Array[]

CSV.open("CsvFiles/csv_file.csv", "r") do |csv|
    csv.each do |row|
        x.push(row)
        puts "#{row}"
    end
end

CSV.open("CsvFiles/csv_file.csv", "a+") do |csv|
    x.each do |i|
        csv << i
    end
end