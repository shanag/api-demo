class Api::V1::AppStatusesController < Api::V1::BaseController 
      
  def index
    respond_with AppStatus.all
  end
  
  def show
    respond_with AppStatus.find(params[:id])
  end
  
  def create
    respond_with AppStatus.create(params[:app_status])
  end
  
  def update
    respond_with AppStatus.update(params[:id], params[:app_status])
  end
  
  def destroy
    respond_with AppStatus.destroy(params[:id])
  end
end
