require "csv"

read_rows = Array[]

CSV.open("CsvFiles/csv_file.csv", "r") do |csv|
    csv.each do |row|
        read_rows.push(row)
        puts "#{row}"
    end
end

CSV.open("CsvFiles/csv_file.csv", "a+") do |csv|
    read_rows.each do |i|
        csv << i
    end
end