
require 'httpclient'
require 'rexml/document'

class DataLoader

    @@cache_file = 'cache.yaml'
    @@url = 'http://www.ezzylearning.com/services/CountryInformationService.asmx/GetCurrencies?' 

    def initialize
        @http = HTTPClient.new
    end 

    def load_all

        if not File.exist? @@cache_file
            load_from_server
        else
            load_from_database
        end

    end

    def load_from_database

        cache = Hash.new

        puts 'Fetching data from local database...'
        yaml = YAML.load_file(@@cache_file)
        
        yaml.each_pair { |object| cache.store(object[0], object[1]) }

        cache

    end

    def load_from_server
    
        puts 'Fetching data from server...'

        response = @http.get @@url
        body = response.body

        document = REXML::Document.new body
       
        cache = process_data document 

        write_cache cache

        cache

    end

    def process_data( document )

        cache = Hash.new
        
        begin

            elem = document.root.elements[2].elements[1]
           
            for table in elem.elements
                if (table.elements.size >= 2)
                    name = table.elements['Currency'].text
                    code = table.elements['CurrencyCode'].text
                    cache.store(code, name)
                end
            end

        rescue Exception => e
            puts 'Error retrieving data from server.' + e.message
        end

        cache

    end

    def write_cache( cache )
   
        puts 'Writing cache...'
        File.open(@@cache_file, "w") do |file|
            file.puts( YAML.dump cache )
        end
    
    end

end


