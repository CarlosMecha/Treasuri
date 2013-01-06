#!/usr/bin/ruby1.9.1

# Treasuri main file.

require_relative 'exchange_data'
require_relative 'data_loader'
require 'yaml'
require 'rexml/document'

class TreasuriContext
    attr_accessor :amount, :c_from, :c_to

    def initialize
        @amount = 1
        @c_from = 'USD'
        @c_to = 'EUR'
    end 
end

def help
    %{Command line options:
* <empty> : Converts 1 USD to EUR.
* help : Shows this help.
* <amount> : Converts <amount> USD to EUR.
* <amount> <from> <to> : Converts <amount> <from> to <to>.}
end

def parse_params( ctx )  

    if (ARGV.size >= 1)
        if (ARGV[0].casecmp('help') == 0)
            puts help
            exit 0
        end

        begin
            ctx.amount= Float(ARGV[0]).round(2)
        rescue ArgumentError
            puts ARGV[0] + ' is not a valid number.'
            exit -1
        end
    end
    if (ARGV.size >= 3)

        ctx.c_from= ARGV[1].upcase
        ctx.c_to= ARGV[2].upcase

    end 

    loader = DataLoader.new
    valid_codes = loader.load_all

    if not (valid_codes[ctx.c_from])
        puts ctx.c_from + ' is not a valid currency code.'
        exit -1
    end

    if not (valid_codes[ctx.c_to])
        puts ctx.c_to + ' is not a valid currency code.'
        exit -1
    end

    ctx
end

puts %{Welcome to Treasuri v0.3
Command: treasuri [ [ help | amount ] from_currency to_currency ]}

ctx = TreasuriContext.new
parse_params ctx

exchange = RateDAO.new

puts 'Getting exchange rates from ' << exchange.source_info

rate = exchange.get ctx.c_from, ctx.c_to, 1 

puts '%.2f %s is %.2f %s.' % [ctx.amount, ctx.c_from, rate.to * ctx.amount, ctx.c_to]

puts '%.2f %s is %.2f %s.' % [ctx.amount, ctx.c_to, (1/rate.to) * ctx.amount, ctx.c_from]

