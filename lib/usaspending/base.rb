module USA

  class Base
    API_URL = "http://www.usaspending.gov"
    
    #construct the url. Requires a database name, currently FAADS or FPDS
    def self.construct_url(database, params)
      if database == nil or database == ''
        raise "Failed to provide a Federal Database such as FAADS or FPDS"
      else
        "#{API_URL}/#{database.downcase}/#{database.downcase}.php?datype=X#{hash2get(params)}"
      end
    end

    # Converts a hash to a GET string
    def self.hash2get(h)

      get_string = ""

      h.each_pair do |key, value|
        get_string += "&#{key.to_s}=#{CGI::escape(value.to_s)}"
      end

      get_string

    end # def hash2get
    
    # Use the Open URI and NokoGiri libraries to make the API call
    #
    # Usage:
    #   Class::Instance.get_data("http://someurl.com")    # returns Hash of data or nil
    def self.get_data(url)

      response = Net::HTTP.get_response(URI.parse(url))
      if response.class == Net::HTTPOK
        result =  Nokogiri::XML.parse(response.body)
      else
        nil
      end
    end # self.get_data
    
  end

end