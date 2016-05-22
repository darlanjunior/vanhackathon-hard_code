class Guess < ActiveRecord::Base
  belongs_to :user

  validates_presence_of [:colors, :exact, :near]
  validates_numericality_of [:exact, :near], {only_integer: true}
  validate :color_values

  def colors= colors
    @colors = colors.join 
  end

  def colors
    @colors.split ''
  end

  def color_values
    errors.add(:colors, 'Invalid color value') unless self.colors.all? {|color| Match.colors.include? color}
  end
end
