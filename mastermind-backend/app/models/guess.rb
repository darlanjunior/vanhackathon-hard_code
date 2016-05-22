class Guess < ActiveRecord::Base
  belongs_to :user
  serialize :colors, Array

  validates_presence_of [:colors, :exact, :near]
  validates_numericality_of [:exact, :near], {only_integer: true}
  validate :color_values

  def color_values
    errors.add(:colors, 'Invalid color value') unless self.colors.all? {|color| Match.colors.include? color}
  end
end
