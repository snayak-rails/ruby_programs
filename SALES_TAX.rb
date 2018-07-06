module ImportedProduct

    def addImportDuty
        self.percentSalesTax += 5
    end

end

module NonTaxable

    def reducePercentSalesTax
        self.percentSalesTax -= 10
    end

end

class Product

    include ImportedProduct
    include NonTaxable

    attr_reader :shelfprice
    attr_accessor :percentSalesTax, :salesTax

    def initialize(shelfprice)
        @shelfprice = shelfprice
        @percentSalesTax = 10
        @salesTax = 0
    end

    def roundOffTax(salesTax)
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

    def calculateTax
        initialSalesTax = (self.percentSalesTax * self.shelfprice)/100.0
        finalSalesTax = roundOffTax(initialSalesTax)

        self.salesTax = finalSalesTax
    end

    def calculateItemPrice
        (self.shelfprice + self.salesTax).round(2)
    end

    def Product.calculateTotalPrice(allProductsArray)
        totalPrice = 0
        allProductsArray.each do |item|
            totalPrice += (item.shelfprice + item.salesTax)
        end

        return totalPrice.round(2)
    end

    def Product.calculateTotalTax(allProductsArray)
        totalTax = 0
        allProductsArray.each do |item|
            totalTax += item.salesTax
        end

        return totalTax.round(2)
    end

end

def calculateResult(arrIn, arrOut)
    arrIn.each do |input|
        
        item = Product.new(input[-1].to_f)

        input.each do |text|
            case text
            when "book", "chocolate", "chocolates", "pills"
                item.reducePercentSalesTax
            when "imported"
                item.addImportDuty
            end     
        end

        item.calculateTax

        arrOut.push(item)
    end
    return arrOut
end

for i in 1..3
    
    arrIn = Array.new
    arrOut = Array.new

    inpTextArr = []

    puts "Input #{i}:"
    while(true)
        x = gets.chomp
        if x == ""
            break
        else
            inpTextArr.push(x)
            arrIn.push(x.split(" "))
        end
    end

    arrOut = calculateResult(arrIn, arrOut)

    puts "Output #{i}:"
    for i in 1..inpTextArr.length
      print "#{inpTextArr[i-1].slice(0, inpTextArr[i-1].length - 8)}: #{arrOut[i-1].calculateItemPrice}\n"
    end

    puts "Sales Tax: #{Product.calculateTotalTax(arrOut)}"
    puts "Total: #{Product.calculateTotalPrice(arrOut)}\n\n"
    
end