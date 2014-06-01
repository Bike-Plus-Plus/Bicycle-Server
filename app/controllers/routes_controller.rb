class RoutesController < ApplicationController
  before_action :authenticate

  def create
    @route_form = RouteForm.new(route_params)
    @route_form.user = current_user

    if @route_form.save
      render json: @route_form.route, status: :created
    else
      render json: @route_form.errors, status: :unprocessable_entity
    end
  end

  protected

  def route_params
    params.require(:route).permit(:start_latitude, :start_longitude, :end_latitude, :end_longitude, :start_address, :end_address)
  end
end
