#!/usr/bin/ruby1.9.1

# Treasuri main file.

require 'httpclient'
require 'json'
require_relative 'response_parser'

def request ( http, query )
    response = http.get query

    # Parsing
    JSON.parse(ResponseParser.parse(response.body))
end

puts 'Welcome to Treasuri v0.1'

http = HTTPClient.new

amount = 1
c_from = 'USD'
c_to = 'EUR'
queryFrom = 'http://www.google.com/ig/calculator?hl=en&q=' << amount.to_s << c_from << '%3D%3F' << c_to
queryTo = 'http://www.google.com/ig/calculator?hl=en&q=' << amount.to_s << c_to << '%3D%3F' << c_from

puts 'Getting finance rates from Google'
jsonResponse = request http, queryFrom

puts sprintf '%s is %s.', jsonResponse['lhs'], jsonResponse['rhs']

jsonResponse = request http, queryTo

puts sprintf '%s is %s.', jsonResponse['lhs'], jsonResponse['rhs']

