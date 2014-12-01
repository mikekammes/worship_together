class ChurchesController < ApplicationController
  def index
    @churches=Church.all
  end
end
