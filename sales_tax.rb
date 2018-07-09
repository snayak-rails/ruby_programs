#!/usr/bin/ruby -w

def calculateTax(shelfPrice, percentSalesTax)
    salesTax = (percentSalesTax * shelfPrice)/100.0
    
    salesTax = salesTax.round(2)

    lastNum = (salesTax * 100) % 10

    if lastNum <= 2
        salesTax = salesTax.floor(1)
    elsif lastNum >= 8
        salesTax = salesTax.ceil(1)
    else
        salesTax = salesTax.floor(1) + 0.05
    end

    return salesTax.round(2)
end

def calcResult(arr, arrOut, totSalesTax, totPrice)
    arr.each do |input|
        shelfPrice = input[-1].to_f
        percentSalesTax = 10
        percentSalesTax = percentSalesTax.to_f

        input.each do |text|
            case text
            when "book", "chocolate", "chocolates", "pills"
                percentSalesTax -= 10
            when "imported"
                percentSalesTax += 5
            end     
        end

        salesTax = calculateTax(shelfPrice, percentSalesTax)

        totPrice.push((shelfPrice + salesTax).round(2))
        totSalesTax.push(salesTax.round(2))
        arrOut.push((salesTax + shelfPrice).round(2))
    end
    return arrOut
end

results = Array.new

for i in 1..3
    
    arr = Array.new
    arrOut = Array.new

    totSalesTax = []
    totPrice = []

    inpTextArr = []

    puts "Input #{i}:"
    while(true)
        x = gets.chomp
        if x == ""
            break
        else
            inpTextArr.push(x)
            arr.push(x.split(" "))
        end
    end

    arrOut = calcResult(arr, arrOut, totSalesTax, totPrice)

    puts "Output #{i}:"
    for i in 1..inpTextArr.length
      print "#{inpTextArr[i-1].slice(0, inpTextArr[i-1].length - 1)}: #{arrOut[i-1]}\n"
    end
    puts "Sales Tax: #{totSalesTax.sum}"
    puts "Total: #{totPrice.sum}\n\n"
    
end
