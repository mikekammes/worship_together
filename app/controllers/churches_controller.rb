class ChurchesController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new,:create,:edit,:update,:destroy]
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
    @churches=Church.all
  end
    def new
	@church = Church.new
	@church.services.build
    end
  
  def update
    @church = Church.find(params[:id])
  end
  
  def edit
    @church = Church.find(params[:id])
  end
  
  def show
    @church = Church.find(params[:id])
  rescue
    flash[:danger] = "unable"
    redirect_to churches_path
  end
  
  def destroy
  end

    def create
	@church = Church.new(church_params)
	@church.user = current_user
	if @church.save
	    flash[:success] = "church created"
	    redirect_to @church
	else
	    flash.now[:danger] = "Unable to create church"
	    render 'new'
	end
    end

    private

    def church_params
	params.require(:church).permit(:name,
				       :web_site,
				       :description,
				       :picture,
				       services_attributes: [ :start_time,
							      :finish_time,
							      :location ] )
    end
  
  def ensure_user_logged_in
    unless logged_in?
      flash[:warning] = 'Not Logged In'
      redirect_to login_path
    end
  end
  
  def ensure_correct_user
    @church = Church.find(params[:id])
    unless current_user?(@church.user)
      flash[:danger] = "Cannot edit other user's curches"
      redirect_to root_path
    end
  end
end
