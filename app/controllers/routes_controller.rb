class RoutesController < ApplicationController
  before_action :authenticate
  before_action :set_route, :only => [:show, :update]

  respond_to :json

  def create
    @route_form = RouteForm.new(route_params)
    @route_form.user = current_user

    if @route_form.save
      render json: @route_form.route, status: :created
    else
      render json: @route_form.errors, status: :unprocessable_entity
    end
  end

  def show
    respond_with @route
  end

  def update
    if @route.update(route_update_params)
      render nothing: true, status: 204
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  protected

  def set_route
    @route = Route.find(params[:id])
  end

  def route_update_params
    params.require(:route).permit(:in_progress, :finished)
  end

  def route_params
    params.require(:route).permit(:start_latitude, :start_longitude, :end_latitude, :end_longitude, :start_address, :end_address)
  end
end
