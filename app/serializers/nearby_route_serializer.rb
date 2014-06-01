class NearbyRouteSerializer < BaseRouteSerializer
  def attributes
    hash = super
    hash["start_range"] = object.start_range if object.respond_to?(:start_range)
    hash["end_range"] = object.end_range if object.respond_to?(:end_range)
    hash["angle_diff"] = object.angle_diff if object.respond_to?(:angle_diff)
    p hash
    hash
  end
end
