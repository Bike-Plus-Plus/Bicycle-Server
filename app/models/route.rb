class Route < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :current_users, class_name: "User", :inverse_of => :current_route
  has_many :route_points
  after_validation :geocode_start, if: ->(obj){ obj.start_address.present? and obj.start_address_changed? }
  after_validation :geocode_end, if: ->(obj){ obj.end_address.present? and obj.end_address_changed? }

end
