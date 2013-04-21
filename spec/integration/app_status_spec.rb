require 'spec_helper'

feature 'app_status' do
  let!(:app_status) { create(:app_status) }
  let!(:old_app_status) { create(:app_status, :status => "DOWN", :message => "App is currently down.") }

  scenario 'view current app status and last 10 app status messages' do
    visit root_path

    within ".current-status" do
      page.should have_content app_status.status
      page.should have_content app_status.message
    end
    
    within ".historical" do
      page.should_not have_content app_status.status
      page.should have_content old_app_status.status
      page.should have_content old_app_status.message
    end

    #should test that there are 10 messages total
  end

end
