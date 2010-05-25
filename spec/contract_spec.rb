require File.dirname(__FILE__) + '/spec_helper'

describe USA::Procurement do

  describe "#intialize" do

    it "should return a contract with a number of instance variables set" do
      xml = File.read("files/single_basic_contract.xml")
      mock_response = mock Net::HTTPOK
      mock_response.should_receive(:body).and_return(xml)
      new_contract = USA::Contract.new(XmlSimple.xml_in(mock_response.body))
      new_contract.vendorname.should eql(["SELKE  KENNETH G MD"])
    end

  end
  
end