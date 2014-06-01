class RouteFormRouteSerializer < BaseRouteSerializer
  embed :ids

  has_many :users
  has_many :nearby_routes
end
