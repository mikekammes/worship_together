class RidesController < ApplicationController
  
  before_action :ensure_user_logged_in, only: [:new,:create, :edit, :update, :destroy]
  
    def index
	order_param = (params[:order] || :Date).to_sym
	ordering = case order_param
		   when :Date
		       :date
		   when :Service
		       :service_id
  when :time_of_day
    time_of_day
		   end
	@rides = Ride.order(ordering)
    end
  
  
  def show
    @ride = Ride.find(params[:id])
  end
  
  def edit
    @ride = Ride.find(params[:id])
  rescue
    flash[:danger] = "Unable to find ride"
    redirect_to ride_path
  end
  
  def update
  end
  
  def destroy
  end
  
  def create
    @ride = Ride.new(ride_params)
    @ride.user_id = current_user.id
    @service = Service.find(params[:Service_id])
    @ride.service_id = @service.id
    if @ride.save
      flash[:success] = "ride created"
      redirect_to @ride
    else
      flash[:danger] = "unable to create ride"
      redirect_to root_path
    end
  end
  
    def ensure_user_logged_in
    unless logged_in?
      flash[:warning] = 'Not Logged In'
      redirect_to login_path
    end
  end
  
end
