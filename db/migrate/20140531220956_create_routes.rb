class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.point :start, :geographic => true
      t.point :end, :geographic => true
      t.point :current, :geographic => true
      t.string :start_address
      t.string :end_address, :default => false
      t.boolean :in_progress, :default => false
      t.boolean :finished
      t.timestamps
    end
  end
end
