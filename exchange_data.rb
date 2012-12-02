require_relative "sources/google_calculator_source"

class RateDAO

    @@default_source = GoogleCalculatorSource.new

    def initialize ( source )
        @source = source
    end 

    def initialize
        @source = @@default_source
    end 

    def get ( from, to, amount )
        @source.get from, to, amount
    end 

    def source_info
        @source.info
    end

end

class Rate
    attr_accessor :from, :to
end

