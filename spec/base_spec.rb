require File.dirname(__FILE__) + '/spec_helper'

describe USA::Base do

  before(:each) do
    @usa = USA::Base.new
  end

  describe "#hash2get" do

    it "should convert a hash to a GET string" do
      get_string = USA::Base.hash2get(:detail => "-1", :state => "AL")
      get_string.should satisfy { |s| s == '&detail=-1&state=AL' or s == '&state=AL&detail=-1' }
    end

  end

  describe "#construct_url" do

    it "should construct a properly formated URL" do
      USA::Base.stub!(:hash2get).and_return("&detail=-1&state=AL")

      url = USA::Base.construct_url("fpds", {})
      url.should eql('http://www.usaspending.gov/fpds/fpds.php?datype=X&detail=-1&state=AL')
    end
    
  end

  describe "#get_data" do

    it "should return Nokogiri Object from a URL" do
      xml = File.read("files/fpds_sample.xml")
      mock_response = mock Net::HTTPOK
      mock_response.should_receive(:class).and_return(Net::HTTPOK)
      mock_response.should_receive(:body).and_return(xml)
      Net::HTTP.should_receive(:get_response).and_return(mock_response)

      data = USA::Base.get_data("http://someurl.com")
      data.children.first.name.should == "usaspendingSearchResults"
      
    end

    it "should return nil when URL returns error code" do
      mock_response = mock Net::HTTPNotFound
      Net::HTTP.should_receive(:get_response).and_return(mock_response)

      data = USA::Base.get_data("http://someurl.com")
      data.should be(nil)
    end

  end

end
