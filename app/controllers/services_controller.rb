class ServicesController < ApplicationController
  def index 
    days=["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    order_param=(params[:order] || :Time).to_sym
    @services = case order_param
    when :Day
      Service.all.to_a.sort_by{ |e| days.index(e.day_of_week) || 8}
    when :Time
      Service.order(:start_time)
    end
  end
  def show
  end
end

