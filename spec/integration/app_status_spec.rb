require 'spec_helper'

feature 'app_status' do
  let!(:app_status) { create(:app_status, :created_at => Date.today) }
  let!(:old_app_status) { create(:app_status, :status => "DOWN", :message => "App is currently down.", :created_at => Date.today - 1.week) }

  scenario 'view current app status and last 10 app status messages' do
    visit root_path
    page.should have_content "App Status"

    within ".current-status" do
      page.should have_content app_status.status
      page.should have_content app_status.message
    end
    
    within ".historical" do
      page.should_not have_content app_status.status
      page.should have_content old_app_status.status
      page.should have_content old_app_status.message
    end

    #make sure there are less than 10 records shown
    all("tr").count.should be <= 10
  end

end
