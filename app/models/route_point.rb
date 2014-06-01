class RoutePoint < ActiveRecord::Base
  belongs_to :route
  belongs_to :user

  before_validation :convert_point
  after_validation :update_route

  attr_accessor :latitude
  attr_accessor :longitude

  validates_presence_of :point
  validate :route_in_progress

  def convert_point
    self.point = "POINT(#{longitude} #{latitude})" if latitude and longitude
  end

  def route_in_progress
    errors.add(:base, "Route not started") unless self.route.in_progress
  end

  def update_route
    self.route.current = self.point
    self.route.save
  end

end
