require File.dirname(__FILE__) + '/spec_helper'

describe USA::Procurement do

  describe "#database" do

    it "should set the database to fpds" do
      new_procure = USA::Procurement.new
      new_procure.database.should eql('fdps')
    end

  end
  
  describe "#detail" do

    it "should return a query with detail set to 0 through 4" do
      get_query = USA::Procurement.new.detail(2)
      get_query.query == {:detail=>2}
    end
    
    it "should return a query with detail set to 1 if not set to 0 through 4" do
      get_query = USA::Procurement.new.detail(5)
      get_query.query == {:detail=>1}
    end

  end
  
  describe "#sortby" do

    it "should return a query with sortby set to single character value of r" do
      get_query = USA::Procurement.new.sort_by("r")
      get_query.query == {:sortby=>"r"}
    end
    
    it "should return a query with sortby set to single character value of r when name" do
      get_query = USA::Procurement.new.sort_by("name")
      get_query.query == {:sortby=>"r"}
    end
    
    it "should return a query with detail set to f if not a correct value" do
      get_query = USA::Procurement.new.sort_by("jesus")
      get_query.query == {:sortby=>"f"}
    end

  end
  
  describe "#max_records" do

    it "should return a query with max records set to 69" do
      get_query = USA::Procurement.new.max_records(69)
      get_query.query == {:max_records=>69}
    end
    
    it "should return a query with max set to 1000 when 1069" do
      get_query = USA::Procurement.new.max_records(1069)
      get_query.query == {:max_records=>1069}
    end

  end
  
  describe "#start_from" do

    it "should return a query with records from set to 69" do
      get_query = USA::Procurement.new.start_from(69)
      get_query.query == {:records_from=>69}
    end
    
    it "should return a query with start set to 1 when 1069" do
      get_query = USA::Procurement.new.start_from(1069)
      get_query.query == {:records_from=>1069}
    end

  end
  
  describe "#years" do

    it "should return a query with fiscal_year set to 2009" do
      get_query = USA::Procurement.new.years(2009)
      get_query.query == {:fiscal_year=>2009}
    end
    
    it "should return a query with fiscal_year set to current year when entry is 5000" do
      get_query = USA::Procurement.new.years(5000)
      get_query.query == {:fiscal_year=>Time.now.year.to_i}
    end
  
    it "should return a query with first_year_range set to 2005 and last_year_range set to 2007 and fiscal_year set to nothing" do
      get_query = USA::Procurement.new.years(2005, 2007)
      get_query.query == {:first_year_range=>2005, :last_year_range=>2007}
    end
    
    it "should return a query with fiscal_year set to time.now.year when first_year_range set to 2005 and last_year_range set to 2004 and fiscal_year set to nothing" do
      get_query = USA::Procurement.new.years(2005, 2004)
      get_query.query == {:fiscal_year=>Time.now.year.to_i}
    end
    
    it "should return a query with fiscal_year set to time.now.year when first_year_range set to 1997 and last_year_range set to 2004 and fiscal_year set to nothing" do
      get_query = USA::Procurement.new.years(1997, 2004)
      get_query.query == {:fiscal_year=>Time.now.year.to_i}
    end
    
    it "should return a query with fiscal_year set to time.now.year when first_year_range set to 2005 and last_year_range set to future year and fiscal_year set to nothing" do
      get_query = USA::Procurement.new.years(2005, Time.now.year+10)
      get_query.query == {:fiscal_year=>Time.now.year.to_i}
    end

  end
  
  describe "#company_name" do

    it "should return a query with company_name set to Boeing" do
      get_query = USA::Procurement.new.company_name("Boeing")
      get_query.query == {:company_name=>"Boeing"}
    end
    
    it "should return a query with nothing" do
      get_query = USA::Procurement.new.company_name("")
      get_query.query == {}
    end
    
  end
  
  describe "#city" do

    it "should return a query with city set to Kansas City" do
      get_query = USA::Procurement.new.city("Kansas City")
      get_query.query == {:city=>"Boeing"}
    end
    
    it "should return a query with nothing" do
      get_query = USA::Procurement.new.city("")
      get_query.query == {}
    end
    
  end
  
  describe "#state" do

    it "should return a query with state set to MO" do
      get_query = USA::Procurement.new.state("MO")
      get_query.query == {:state=>"MO"}
    end
    
    it "should return a query with state set to MO" do
      get_query = USA::Procurement.new.state("MO", "performance")
      get_query.query == {:stateCode=>"MO"}
    end
    
  end
  
  describe "#zip" do

    it "should return a query with zip set to 66411" do
      get_query = USA::Procurement.new.zip("66411")
      get_query.query == {:ZIPCode=>"66411"}
    end
    
    it "should return a query with zip set to 66411" do
      get_query = USA::Procurement.new.zip("66411")
      get_query.query == {:placeOfPerformanceZIPCode=>"66411"}
    end
        
  end
  
  describe "#country" do

    it "should return a query with vendor country set to AC" do
      get_query = USA::Procurement.new.country("AC")
      get_query.query == {:vendorCountryCode=>"AC"}
    end
    
    it "should return a query with performace country set to AC" do
      get_query = USA::Procurement.new.country("AC", "performance")
      get_query.query == {:placeOfPerformanceCountryCode=>"AC"}
    end
    
    it "should return an error with performace country set to 123" do
      get_query = USA::Procurement.new.country("123", "performance")
      get_query.errors == {:country=>"Couldn't find the country code."}
    end
    
  end
  
  describe "#congress_district" do

    it "should return a query with vendor congressional district set to AL01" do
      get_query = USA::Procurement.new.congress_district("AL01")
      get_query.query == {:vendor_cd=>"AL01"}
    end
    
    it "should return a query with performace country set to AL01" do
      get_query = USA::Procurement.new.congress_district("AL01", "performance")
      get_query.query == {:pop_cd=>"AL01"}
    end
    
    it "should return an error with performace country set to 123" do
      get_query = USA::Procurement.new.congress_district("123", "performance")
      get_query.errors == {:congress_district=>"Couldn't find that congressional district code."}
    end
    
  end
  
  describe "#competition_status" do

    it "should return a query with competition_status set to single character value of c" do
      get_query = USA::Procurement.new.competition_status("c")
      get_query.query == {:complete_cat=>"c"}
    end
    
    it "should return a query with competition_status set to single character value of c when everyone" do
      get_query = USA::Procurement.new.competition_status("everyone")
      get_query.query == {:complete_cat=>"c"}
    end
    
    it "should return a query with competition_status set to u if not a correct value" do
      get_query = USA::Procurement.new.competition_status("jesus")
      get_query.query == {:complete_cat=>"u"}
    end

  end
  
  describe "#piid" do

    it "should return a query with piid set to value" do
      get_query = USA::Procurement.new.piid("c")
      get_query.query == {:PIID=>"c"}
    end
    
  end
  
  describe "#contract_requirement" do

    it "should return a query with piid set to value" do
      get_query = USA::Procurement.new.contract_requirement("c")
      get_query.query == {:descriptionOfContractRequirement=>"c"}
    end
    
  end
  
  describe "#duns_number" do

    it "should return a query with duns_number set to value" do
      get_query = USA::Procurement.new.duns_number("c")
      get_query.query == {:duns_number=>"c"}
    end
    
  end
  
  describe "#program_description" do

    it "should return a query with program_description set to value" do
      get_query = USA::Procurement.new.program_description("c")
      get_query.query == {:program_source_desc=>"c"}
    end
    
  end
  
  describe "#business_fund" do

    it "should return a query with business_fund set to value" do
      get_query = USA::Procurement.new.business_fund("r")
      get_query.query == {:busn_indctr=>"r"}
    end
    
  end
  
  describe "#program_code" do

    it "should return a query with program_code set to value" do
      get_query = USA::Procurement.new.program_code("r")
      get_query.query == {:program_source_agency_code=>"r"}
    end
    
  end
  
  describe "#program_account" do

    it "should return a query with program_account set to value" do
      get_query = USA::Procurement.new.program_account("r")
      get_query.query == {:program_source_account_code=>"r"}
    end
    
  end
  
  
  describe "#agency" do

    it "should return a query with agency to 0000" do
      get_query = USA::Procurement.new.agency("0000")
      get_query.query == {:mod_agency=>"0000"}
    end
    
    it "should return an error with code set to 123000000" do
      get_query = USA::Procurement.new.agency("123000000")
      get_query.errors == {:agency=>"Couldn't find that agency specific code."}
    end
    
  end
  
  describe "#major_agency" do

    it "should return a query with major_agency code to 12" do
      get_query = USA::Procurement.new.major_agency("12")
      get_query.query == {:maj_agency_cat=>"12"}
    end
    
  
    it "should return an error with major_agency code set to 123000000" do
      get_query = USA::Procurement.new.major_agency("123000000")
      get_query.errors == {:agency=>"Couldn't find that agency specific code."}
    end
    
  end
  
  describe "#product_category" do

    it "should return a query with product_category code to 10" do
      get_query = USA::Procurement.new.product_category("10")
      get_query.query == {:psc_cat=>"10"}
    end
    
    it "should return an error with product_category code set to 123000000" do
      get_query = USA::Procurement.new.product_category("123000000")
      get_query.errors == {:product_category=>"Couldn't find that major product category code."}
    end
    
  end
  
  describe "#product" do

    it "should return a query with product code to 1005" do
      get_query = USA::Procurement.new.product("1005")
      get_query.query == {:psc_sub=>"1005"}
    end
    
    it "should return an error with product code set to 123000000" do
      get_query = USA::Procurement.new.product("123000000")
      get_query.errors == {:product=>"Couldn't find that major product category code."}
    end
    
  end
  
  

end
