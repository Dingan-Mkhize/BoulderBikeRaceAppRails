class RidersController < ApplicationController
  def index
    @riders = Rider.all
    render json: @riders
  end
end
