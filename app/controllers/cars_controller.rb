class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(post_params)
    if @car.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @cae = Car.find(params[:id])
    if @car.update(car)
      redirect_to @poscart, notice: 'car was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @car = car.find(params[:id])
    @car.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def car_params
    params.require(:car).permit(:make, :price, :vin, :description, :year, :date_arrived, :date_sold)
  end
end

