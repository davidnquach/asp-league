class CreateRateLimits < ActiveRecord::Migration
  def change
    create_table :rate_limits do |t|
      t.integer :time
      t.integer :requests

      t.timestamps null: false
    end
  end
end
