class CreateGamePlayer < ActiveRecord::Migration
  def change
    create_table :games_players do |t|
      t.integer :game_id
      t.integer :player_id
    end
  end
end
