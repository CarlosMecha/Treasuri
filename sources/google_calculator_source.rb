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
        rate.from= jsonResponse['lhs'] 
        rate.to= jsonResponse['rhs']

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

