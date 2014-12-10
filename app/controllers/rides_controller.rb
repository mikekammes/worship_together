class RidesController < ApplicationController
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
    order_param = (params[:Service]).to_sym
	ordering = case order_param
  when :Service
    :service_id
    @rides = Service.order(ordering)
  end
  end
end
