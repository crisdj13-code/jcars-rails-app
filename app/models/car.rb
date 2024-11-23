class Car < ApplicationRecord
  has_many :posts
  validates_presence_of :make, :year
end
