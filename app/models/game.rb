class Game < ActiveRecord::Base
  has_many :spaces
  has_and_belongs_to_many :players

  before_create :generate_spaces


  def generate_spaces
    

  end
end
