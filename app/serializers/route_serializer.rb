class RouteSerializer < BaseRouteSerializer
  embed :ids, include: true

  has_many :users
  has_many :nearby_routes, serializer: NearbyRouteSerializer

end
