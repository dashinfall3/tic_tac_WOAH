class Game < ActiveRecord::Base
  has_many :spaces
  has_and_belongs_to_many :players
end
