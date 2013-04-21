class AppStatusesController < ApplicationController
  respond_to :html, :json

  def index
    @app_statuses = AppStatus.all
    respond_with @app_statuses 
  end

end
