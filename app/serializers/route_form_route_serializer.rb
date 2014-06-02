class RouteFormRouteSerializer < ActiveModel::Serializer
  attributes :id, :start_latitude, :start_longitude, :current_latitude, :current_longitude, :end_latitude, :end_longitude, :in_progress, :finished

  embed :ids

  has_many :users
  has_many :nearby_routes, key: :routes
end
