class User < ActiveRecord::Base
  belongs_to :current_route, class_name: "Route", inverse_of: :current_users
  has_and_belongs_to_many :routes
end
