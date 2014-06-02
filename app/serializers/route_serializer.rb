class RouteSerializer < ActiveModel::Serializer
  attributes :id, :start_latitude, :start_longitude, :current_latitude, :current_longitude, :end_latitude, :end_longitude, :in_progress, :finished


  has_many :users, embed: :ids, :include => true
  has_many :nearby_routes, serializer: NearbyRouteSerializer, root: :routes, embed: :ids


end
