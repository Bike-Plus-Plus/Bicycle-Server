class PointsController < ApplicationController
  before_action :authenticate

  def create
    @route = Route.find(params[:route_id])
    @route_point = RoutePoint.new(point_params)
    @route_point.route = @route

    if @route_point.save
      render json: @route_point, status: :created, serializer: PointSerializer
    else
      render json: @route_point.errors, status: :unprocessable_entity
    end
  end

  protected

  def point_params
    params.require(:point).permit(:latitude, :longitude)
  end

end