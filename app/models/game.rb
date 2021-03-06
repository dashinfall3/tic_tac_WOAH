class Game < ActiveRecord::Base
  has_many :spaces
  has_and_belongs_to_many :players

  def latest_player
    @latest_player = self.spaces.order("updated_at").last.player
  end 

  def latest_space
    @latest_space = self.spaces.order("updated_at").last.space_location
  end 

  def generate_spaces
    (0..8).each do |space|
      Space.create(:game_id => self.id, :space_location => space, :status => 0)
    end
  end
end
