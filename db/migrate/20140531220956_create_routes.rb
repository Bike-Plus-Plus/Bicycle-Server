class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.point :start, :geographic => true
      t.point :end, :geographic => true
      t.point :current, :geographic => true
      t.string :start_address
      t.string :end_address
      t.timestamps
    end
  end
end
