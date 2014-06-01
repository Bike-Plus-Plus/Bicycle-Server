class CreateRouteConnections < ActiveRecord::Migration
  def change
    create_table :route_connections do |t|
      t.references :route, index: true
      t.references :nearby_route, index: true
      t.decimal :start_range
      t.decimal :end_range
      t.decimal :angle_diff
      t.timestamps
    end
  end
end
