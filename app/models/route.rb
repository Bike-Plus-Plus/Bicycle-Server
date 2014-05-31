class Route < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :current_users, class_name: "User", :inverse_of => :current_route
  has_many :route_points
end
