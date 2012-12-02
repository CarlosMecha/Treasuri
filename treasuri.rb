#!/usr/bin/ruby1.9.1

# Treasuri main file.

@@amount = 1
@@c_from = 'USD'
@@c_to = 'EUR'

def parse_params

    if (ARGV.size >= 1)
        begin
            @@amount = Float(ARGV[0]).round(2)
        rescue ArgumentError
            puts ARGV[0] + ' is not a valid number.'
            @@amount = 1
        end
        puts 'Amount to convert: ' << @@amount.to_s
    end

end


require_relative 'exchange_data'

puts 'Welcome to Treasuri v0.1'

parse_params

exchange = RateDAO.new

puts 'Getting exchange rates from ' << exchange.source_info

rate = exchange.get @@c_from, @@c_to, @@amount

puts '%s is %s.' % [rate.from, rate.to]

rate = exchange.get @@c_to, @@c_from, @@amount

puts '%s is %s.' % [rate.from, rate.to]

