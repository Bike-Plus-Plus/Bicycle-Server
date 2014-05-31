class CreateRoutePoints < ActiveRecord::Migration
  def change
    create_table :route_points do |t|
      t.references :route, index: true
      t.point :point, :geographic => true
      t.timestamps
    end
  end
end
