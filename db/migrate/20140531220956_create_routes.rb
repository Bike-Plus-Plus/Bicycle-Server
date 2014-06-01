class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.point :start_point, :geographic => true
      t.point :end_point, :geographic => true
      t.point :current, :geographic => true
      t.string :start_address
      t.string :end_address
      t.boolean :in_progress, :default => false
      t.boolean :finished, :default => false
      t.timestamps
    end
  end
end
