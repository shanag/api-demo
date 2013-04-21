require 'spec_helper'

describe "app_status", :type => :api do
  before do
    @app_status = create(:app_status)
  end

  context "view app status" do
    let(:url) { "/api/v1/app_statuses" }
    
    it "json" do
      get "#{url}.json"
      app_status_json = AppStatus.limit(10).to_json
      response.body.should eql(app_status_json)
      response.status.should eql(200)
      app_statuses = JSON.parse(response.body)
      app_statuses.any? do |a|
        a["status"] == "UP"
      end.should be_true
    end
  
    it "xml" do
      get "#{url}.xml"
      app_status_xml = AppStatus.limit(10).to_xml
      response.body.should eql(app_status_xml)
      response.status.should eql(200)
      app_statuses = Nokogiri::XML(response.body)
      app_statuses.css("status").text.should eql("UP")
    end
  end
  
  context "create app status" do
    let(:url) { "/api/v1/app_statuses" }
    
    it "json" do
      post "#{url}.json", :app_status => {:status => "DOWN", :message => "The app is down"}
      app_status = AppStatus.last
      response.status.should eql(201)
      response.body.should eql(app_status.to_json)
    end 

    it "xml" do
      pending
    end
  
  end

  context "update app status" do
    let(:url) { "/api/v1/app_statuses/1" }
    
    it "json" do
      put "#{url}", {:format => :json, :app_status => {:status => "DOWN", :message => "The app status has been updated"}}
      app_status = AppStatus.find(1)
      response.status.should eql(204)
    end 
 
    it "xml" do
      pending
    end
  end

end
