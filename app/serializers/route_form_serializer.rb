class RouteFormSerializer < ActiveModel::Serializer
  self.root = false

  has_one :route, serializer: RouteFormRouteSerializer
  has_many :users
  has_many :nearby_routes, serializer: NearbyRouteSerializer, key: "routes"
end
