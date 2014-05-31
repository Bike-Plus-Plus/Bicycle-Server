class CreateRoutesUsers < ActiveRecord::Migration
  def change
    create_table :routes_users do |t|
      t.references :user, index: true
      t.references :route, index: true

      t.timestamps
    end
  end
end
