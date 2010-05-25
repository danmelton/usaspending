module USA

  class Procurement < Base

    def initialize
      @database = 'fpds'
      @query = {}
      @errors = {}
    end
    
    #returns current database
    def database
      @database
    end
    
    def errors
      @errors
    end
    
    # city  The city within a contractor's address   
    def city(city_value)
      @query[:city] = city_value unless city_value == ""
      self
    end

    #accepts abbreviate country letters and vendor or performance for place of performance, defaults to vendor    
    def country(country_abbr_value, location_type='vendor')
      require "../lib/codes/countries.rb"
      if country_codes["#{country_abbr_value}"] 
      location_type != 'vendor' ? @query[:placeOfPerformanceCountryCode] = country_abbr_value : @query[:vendorCountryCode] = country_abbr_value  
      else
        @errors[:country] = "Couldn't find the country code."
      end
      self
    end
    
    #accepts abbreviated list of congressional districts and vendor or performance, defaults to vendor
    def congress_district(congress_value, location_type='vendor')
      require '../lib/codes/congress_districts.rb'
      if congress_districts["#{congress_value}"]
      location_type != 'vendor' ? @query[:pop_cd] = congress_value : @query[:vendor_cd] = congress_value  
      else
        @errors[:congress_district] = "Couldn't find that congressional district code."
      end
      self
    end 
    
    def piid(piid_value)
      @query[:PIID] = piid_value
      self
    end
    
    def contract_requirement(description)
      @query[:descriptionOfContractRequirement] = description
      self
    end
    
    #he contractor duns number.
    def duns_number(duns_value)
      @query[:duns_number] = duns_value
      self
    end
    
    #Full text search of program source description.
    def program_description(description)
      @query[:program_source_desc] = description
      self
    end
    
    # Determines the Business Fund Indicator:
    # r = funds provided by Recovery Act
    def business_fund(fund_value)
      @query[:busn_indctr] = fund_value
      self
    end

    #The program source agency code.
    def program_code(code_value)
      @query[:program_source_agency_code] = code_value
      self
    end

    #The program source account code.
    def program_account(account_value)
      @query[:program_source_account_code] = account_value
      self
    end
    
    #The 4-digit code for a specific governmental agency issuing contracts. See here http://www.usaspending.gov/apidocsmore.html#FPDS_AGENCY.
    def agency(code)
      require '../lib/codes/fpds_agencies.rb'
      if agency_codes["#{code}"]
        @query[:mod_agency] = code  
      else
        @errors[:agency] = "Couldn't find that agency specific code."
      end
      self
    end
    
    #The 2-character code for a major governmental agency issuing contracts. See here http://www.usaspending.gov/apidocsmore.html#FPDS_MAJAGENCY for list.
    def major_agency(code)
      require '../lib/codes/fpds_agencies.rb'
      if major_codes["#{code}"]
        @query[:maj_agency_cat] = code  
      else
        @errors[:major_agency] = "Couldn't find that major agency category code."
      end
      self
    end
    
    # The 2-character code for a major product or service category. See here http://www.usaspending.gov/apidocsmore.html#PSCCAT for list.
    def product_category(code)
      require '../lib/codes/products_services.rb'
      if product_category_codes["#{code}"]
        @query[:psc_cat] = code  
      else
        @errors[:product_category] = "Couldn't find that major product category code."
      end
      self
    end

    # The 4-character code for a product or service. See here http://www.usaspending.gov/apidocsmore.html#PSC for list.  
    def product(code)
      require '../lib/codes/products_services.rb'
      if product_codes["#{code}"]
        @query[:psc_sub] = code  
      else
        @errors[:product] = "Couldn't find that product code."
      end
      self
    end
    
    # The competition status of a contract. Values are:
    #   everyone or c = Available for everyone for competition
    #   one offer or o = Everyone could compete, but only one bid or offer was recieved
    #   pool  p = Competition within a limited pool
    #   no  n = Not competed for an allowable reason
    #   groups  a = Available only for groups such as disabled persons, prisoners, and regulated utilities
    #   actions  f = Actions necessary to continue existing competitive contracts for continuity (until the next one could be competed)
    #   unknown  u = Not identified, soon to be addressed
    # compete_cat
    
    def competition_status(cat_value)
      @query[:complete_cat] = case cat_value
      when "everyone", "c" then "c"
      when "One offer", "o" then "o"
      when "pool", "p" then "p"
      when "no", "n" then "n"
      when "groups", "a" then "a"
      when "actions", "f" then "f"
      else "u"
      end
      self
    end

    # state The state abbreviation within a contractor's address.    
    def state(state_value, location_type='vendor')
      location_type != 'vendor' ? @query[:stateCode] = state_value : @query[:state] = state_value  
      self
    end

    # ZIPCode The ZIP code within a contractor's address.    
    def zip(zip_value, location_type='vendor')
      location_type != 'vendor' ? @query[:placeOfPerformanceZIPCode] = zip_value : @query[:ZIPCode] = zip_value  
      self
    end
    
    #Specify a company name
    def company_name(company_name_value = nil)
      @query[:company_name] = company_name_value unless company_name_value == ""
      self
    end
    
    # Determines how records are sorted. Valid values are:
    # name or r = by contractor or recipient name
    # dollars or f = by dollars of awards (in descending order)
    # major or g = by major contracting agency
    # category or p = by Product or Service Category
    # date or d = by date of award
    # Defaults to sort by dollars if not provided.
    def sort_by(sortby_number)
      @query[:sortby] = case sortby_number 
      when "name", "r" then "r"
      when "dollars", "f" then "f"
      when "major agency", "g" then "g"
      when "category", "p" then "p"
      when "date", "d" then "d"
      else "f"
      end
      self
    end
    
    #specify time frame in years.  Requires start value if specified, otherwise, leaving this function will default to all fiscal years
    #entering a wrong year will default to the current year
    def years(s_year, end_year = nil )
      start_year = s_year.to_i
      end_year = end_year.to_i unless end_year.nil?
      if end_year
        if start_year < 2000 || start_year > Time.now.year.to_i + 1
          @errors[:years] = "Problem with Start Year"
        else  
          if end_year > start_year && end_year < Time.now.year.to_i + 1
            @query[:first_year_range] = start_year
            @query[:last_year_range] = end_year
          else
            @errors[:years] = "Problem with End Year"
          end        
        end
      elsif start_year < 2000 or start_year > Time.now.year.to_i + 1
        @errors[:years] = "Problem with Start Year"
      else
        @query[:fiscal_year] = start_year  
      end
      self
    end
    
    # Allows you to set the starting position of the records to be retrieved, defaults to 1 if less than 0
    def start_from(start_number)
      @query[:records_from] = start_number > 0 ? start_number : 1
      self
    end
    
    #Allows you to set the maximum number of records retrieved to fewer than 1000
    # defaults to 1000 when over a 1000
    def max_records(max_number)
      @query[:max_records] = max_number.to_i < 1000 ? max_number : 1000
      self
    end
    
    def record(record_number)
      #set the detail to c
      self.detail("c")
      @query[:record_id] = record_number
      self
    end
    
    # accepts values b or c, defaults to b 
    def detail(detail_number)
      if ["b", "c"].include?(detail_number.downcase)
        detail_value = detail_number
      else
        detail_value = "b"
      end  
      @query[:detail] = detail_value
      self
    end
    
    #return current query
    def query
      @query
    end
    
    # Clears all the query filters to make a new search
    def clear
      @fetch = nil
      @query = {}
      self
    end

    def url
      construct_url(database, @query)
    end

    # Fetch the Procurement Search returning parsed xml
    def fetch
      get_data(url)
    end
    
    # Fetch the Procurement Search returning array of contract objects
    def fetch_contracts
      contracts = []
      self.fetch["result"].first.first[1].each do |contract|
        contracts << USA::Contract.new(contract)
      end
      return contracts
    end

  end # class Procurement
  
end # module USA