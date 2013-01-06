require 'httpclient'
require 'json'

class GoogleCalculatorSource

    @@url = 'http://www.google.com/ig/calculator?hl=en&q=%i%s%%3D%%3F%s'

    def initialize
        @http = HTTPClient.new
    end 

    def get( from, to, amount )
        query = sprintf @@url, amount, from, to

        request query
    end 

    def response_parse ( body )
        body.gsub! "lhs", "\"lhs\""
        body.gsub! "rhs", "\"rhs\""
        body.gsub! "icc", "\"icc\""
        body.gsub! "error", "\"error\""
                                                                                    
        jsonResponse = JSON.parse body

        rate = Rate.new
        from= /[[:digit:]]+(\.[[:digit:]]+)?/.match(jsonResponse['lhs'])
        to= /[[:digit:]]+(\.[[:digit:]]+)?/.match(jsonResponse['rhs'])

        rate.from= Float(from[0]) if from and from.size > 0
        rate.to= Float(to[0]) if from and from.size > 0

        rate
    end 

    def request ( query )
        response = @http.get query

        response_parse response.body
    end 

    def info
        'Google Calculator API'
    end

end

