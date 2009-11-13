class CreateFollowers < ActiveRecord::Migration
  def self.up
    create_table :followers do |t|
      t.string :twitter_id
      t.string :location
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lng, :precision => 15, :scale => 10
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :followers
  end
end
