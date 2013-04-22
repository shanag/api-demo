require 'spec_helper'

describe "app_status", :type => :api do
  before do
    @version = "v1"
    @app_status = create(:app_status)
  end

  context "view app status" do
    let(:url) { "/api/#{@version}/app_statuses" }
    
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
    let(:url) { "/api/#{@version}/app_statuses" }
    
    it "json" do
      post "#{url}.json", :app_status => {:status => "DOWN", :message => "The app is down"}
      app_status_json = AppStatus.first.to_json
      response.status.should eql(201)
      response.body.should eql(app_status_json)
    end 

    it "xml" do
      post "#{url}.xml", :app_status => {:status => "DOWN", :message => "The app is down"}
      app_status_xml = AppStatus.first.to_xml
      response.status.should eql(201)
      response.body.should eql(app_status_xml)
    end
  end

  context "update app status" do
    let(:url) { "/api/#{@version}/app_statuses/1" }
    
    it "json" do
      put "#{url}", {:format => :json, :app_status => {:status => "DOWN", :message => "The app status has been updated"}}
      app_status = AppStatus.find(1)
      response.status.should eql(204)
    end 
 
    it "xml" do
      put "#{url}", {:format => :xml, :app_status => {:status => "DOWN", :message => "The app status has been updated"}}
      app_status = AppStatus.find(1)
      response.status.should eql(204)
    end
  end
  
  context "destroy app status" do
    let(:url) { "/api/#{@version}/app_statuses/1" }
    
    it "json" do
      delete "#{url}"
      expect{ get "#{url}" }.to raise_error(ActiveRecord::RecordNotFound)
    end 
 
    it "xml" do
      delete "#{url}"
      expect{ get "#{url}" }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
