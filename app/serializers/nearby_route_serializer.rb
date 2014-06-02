class NearbyRouteSerializer < ActiveModel::Serializer
  attributes :id, :start_latitude, :start_longitude, :current_latitude, :current_longitude, :end_latitude, :end_longitude, :in_progress, :finished

  embed :ids
  has_many :users
  has_many :nearby_routes

  def attributes
    hash = super
    hash["start_range"] = object.start_range if object.respond_to?(:start_range)
    hash["end_range"] = object.end_range if object.respond_to?(:end_range)
    hash["angle_diff"] = object.angle_diff if object.respond_to?(:angle_diff)
    hash
  end
end
