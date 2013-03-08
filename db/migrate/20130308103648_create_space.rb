class CreateSpace < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.integer :game_id
      t.integer :space_location
      t.integer :status
      t.integer :player_id
      t.timestamps
    end
  end
end
