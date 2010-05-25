module USA

  class Contract < Base
    
    attr_accessor :transactionnumber, :programsourcedescription, :programsource, :majorfundingagency, :facevalue, :dollarsobligated, :competitioncategory, :vendorname, :typeofspending, :recipientzipcode, :datesigned, :typeoftransaction, :placeofperformancestate, :psccategorycode, :contractpricing, :idvprocurementinstrumentid, :awardtype, :record_count, :recipientstate, :parentrecipientorcompanyname, :idvagency, :fundingagency, :recipientcountyname, :recipientaddressline123, :projectdescription, :principalnaicscode, :modificationnumber, :recipientorcontractorname, :recipientcity, :programsourceagencycode, :programsourceaccountcode, :federalawardid, :fiscalyear, :majoragency, :contractororrecipientid, :recipientcongressionaldistrict, :productorservicecode, :procurementinstrumentid, :placeofperformancecongdistrict, :extentcompeted, :dunsnumber, :recipientname, :principalplacecountyorcity, :placeofperformancezipcode, :contractingagency
    
    def initialize(params)
      if params
        self.set_instance_methods(params)
      end
    end
    

    
  end

end  