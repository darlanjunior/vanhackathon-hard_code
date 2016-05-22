class User < ActiveRecord::Base
  has_many :guesses
  belongs_to :match

  validates :name, uniqueness: true
end
