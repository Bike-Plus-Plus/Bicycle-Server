require 'geocoder'

class Route < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :current_users, class_name: "User", :inverse_of => :current_route, foreign_key: :current_route_id
  has_many :route_points
  after_validation :geocode_start, if: ->(obj){ obj.start_address.present? and obj.start_address_changed? }
  after_validation :geocode_end, if: ->(obj){ obj.end_address.present? and obj.end_address_changed? }
  before_create :copy_start_address_to_current

  def geocode_start
    result = Geocoder.search(start_address).first
    self.start_point = "POINT(#{result.coordinates[1]} #{result.coordinates[0]})"
  end

  def geocode_end
    result = Geocoder.search(end_address).first
    self.end_point = "POINT(#{result.coordinates[1]} #{result.coordinates[0]})"
  end

  def copy_start_address_to_current
    self.current = self.start_point
  end

end
