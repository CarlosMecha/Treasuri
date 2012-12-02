#!/usr/bin/ruby1.9.1

# Treasuri main file.

require_relative 'exchange_data'
require_relative 'data_loader'
require 'yaml'
require 'rexml/document'

@@amount = 1
@@c_from = 'USD'
@@c_to = 'EUR'
@@valid_codes = Array.new

def print_help
    puts 'Command line options:'
    puts '* : Converts 1 USD to EUR.'
    puts '* help : Shows this help.'
    puts '* <amount> : Converts <amount> USD to EUR.'
    puts '* <amount> <from> <to> : Converts <amount> <from> to <to>.'
end

def parse_params   

    if (ARGV.size >= 1)
        if (ARGV[0].casecmp('help') == 0)
            print_help
            exit 0
        end

        begin
            @@amount = Float(ARGV[0]).round(2)
        rescue ArgumentError
            puts ARGV[0] + ' is not a valid number.'
            exit -1
        end
    end
    if (ARGV.size >= 3)

        @@c_from = ARGV[1].upcase
        @@c_to = ARGV[2].upcase

    end 
end

puts 'Welcome to Treasuri v0.1'
puts 'Command: treasuri [ [ help | amount ] from_currency to_currency ]'

loader = DataLoader.new
@@valid_codes = loader.load_all

parse_params

if not (@@valid_codes[@@c_from])
    puts @@c_from + ' is not a valid currency code.'
    exit -1
end

if not (@@valid_codes[@@c_to])
    puts @@c_to + ' is not a valid currency code.'
    exit -1
end

exchange = RateDAO.new

puts 'Getting exchange rates from ' << exchange.source_info

rate = exchange.get @@c_from, @@c_to, @@amount

puts '%s is %s.' % [rate.from, rate.to]

rate = exchange.get @@c_to, @@c_from, @@amount

puts '%s is %s.' % [rate.from, rate.to]

