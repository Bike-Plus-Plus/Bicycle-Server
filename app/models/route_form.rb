class RouteForm
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :user

  attribute :start_latitude, BigDecimal
  attribute :start_longitude, BigDecimal
  attribute :end_latitude, BigDecimal
  attribute :end_longitude, BigDecimal
  attribute :start_address, String
  attribute :end_address, String

  validates_each :user, :route do |record, attr, value|
    if value and value.invalid?
      value.errors.each do |key, error|
        record.errors[key] = error
      end
    end
  end

  def save
    if valid?
      save_route
      save_user
      save_nearby_routes
      return true
    else
      return false
    end
  end

  def save_route
    route.users << user
    route.save
  end

  def save_user
    user.current_route = route
    user.save
  end

  def save_nearby_routes
    nearby_routes.each do |nearby_route|
      RouteConnection.create_between(route,
        nearby_route,
        nearby_route.start_range,
        nearby_route.end_range,
        nearby_route.angle_diff)
    end
  end

  def nearby_routes
    @nearby_routes ||= RouteProximityQuery.new(route).routes
  end

  def start_point
    @start_point ||= "POINT(#{start_longitude} #{start_latitude})" if start_latitude and start_longitude
  end

  def end_point
    @end_point ||= "POINT(#{end_longitude} #{end_latitude})" if end_latitude and end_longitude
  end

  def users
    route.users
  end

  def route
    @route ||= begin
      r = Route.new
      r.start_point = start_point if start_point
      r.end_point = end_point if end_point
      r.start_address = start_address if start_address
      r.end_address = end_address if end_address
      r
    end
  end
end