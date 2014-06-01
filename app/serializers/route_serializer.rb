class RouteSerializer < BaseRouteSerializer
  embeds :ids, include: true

  has_one :user
  has_many :nearby_routes, serializer: NearbyRouteSerializer

end
