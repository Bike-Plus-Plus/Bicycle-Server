class RouteConnection < ActiveRecord::Base
  belongs_to :route
  belongs_to :nearby_route, :class_name => "Route", foreign_key: :nearby_route_id

  def self.create_between(route, nearby_route, start_range, end_range, angle_diff)
    route_connection_from ||= RouteConnection.new do |rc|
      rc.route   = route
      rc.nearby_route = nearby_route
    end
    route_connection_from.start_range = start_range
    route_connection_from.end_range = end_range
    route_connection_from.angle_diff = angle_diff

    route_connection_to ||= RouteConnection.new do |rc|
      rc.route   = nearby_route
      rc.nearby_route = route
    end
    route_connection_to.start_range = start_range
    route_connection_to.end_range = end_range
    route_connection_to.angle_diff = angle_diff

    RouteConnection.transaction do
      route_connection_from.save
      route_connection_to.save
    end
  end

end
