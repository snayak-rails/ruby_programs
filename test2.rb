#!/usr/bin/ruby -w

$global_var = 10

class Customer

    @@no_of_customers = 0

    def initialize(id, name, addr)
        @cust_id = id
        @cust_name = name
        @cust_address = addr

        @@no_of_customers += 1
    end

    def display_details()
        puts "Customer id is #@cust_id"
        puts "Customer name is #@cust_name"
        puts "Customer address is #@cust_address \n\n"
    end

    def disp_no_of_customers()
        puts "Total customers = #@@no_of_customers \n\n"
    end

end

cust1 = Customer.new("1", "hoho", "uyhbbw")
cust1.disp_no_of_customers

cust2 = Customer.new("1", "uiiiug", "uyhbbwhefuibew")
cust2.disp_no_of_customers

cust1.display_details()
cust2.display_details()

puts "the global variable is #$global_var"