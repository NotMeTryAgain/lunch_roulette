class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:notice] = "Location Saved!"
      binding.pry
      redirect_to locations_path
    else
      flash[:error] = "Not Saved!"
      render :index
    end
  end

  private

  def location_params
    params.require(:location).permit(
    :address
    )
  end
end
