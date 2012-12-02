

class ResponseParser

    def ResponseParser.parse( body )
        body.gsub! "lhs", "\"lhs\""
        body.gsub! "rhs", "\"rhs\""
        body.gsub! "icc", "\"icc\""
        body.gsub! "error", "\"error\""
    end

end
