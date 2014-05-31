class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.point :start, :geographic => true
      t.point :end, :geographic => true
      t.point :current, :geographic => true
      t.timestamps
    end
  end
end
