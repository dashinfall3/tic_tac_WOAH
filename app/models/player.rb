class Player < ActiveRecord::Base
  has_and_belongs_to_many :games
  has_many :spaces
  has_secure_password
  validates :email, :presence => true, :uniqueness => true
end
