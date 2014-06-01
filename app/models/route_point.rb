class RoutePoint < ActiveRecord::Base
  belongs_to :route

  before_save :convert_point

  attr_accessor :latitude
  attr_accessor :longitude

  def convert_point
    self.point = "POINT(#{longitude} #{latitude})"
  end

end
