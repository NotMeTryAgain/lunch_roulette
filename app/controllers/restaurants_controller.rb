class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      flash[:error] = @restaurant.errors.full_messages.join(". ")
      render :new
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      flash[:notice] = "Restaurant Updated!"
      redirect_to restaurant_path(@restaurant)
    else
      flash[:error] = @restaurant.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy!
      flash[:notice] = "Restaurant Destroyed!"
      redirect_to restaurants_path
    else
      flash[:error] = @restaurant.errors.full_messages.join(". ")
      redirect_to restaurant_path(@restaurant)
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(
      :name,
      :category,
      :address,
      :city,
      :state,
      :zip
    )
  end
end
