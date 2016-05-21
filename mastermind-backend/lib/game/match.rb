require 'pry'
class Match
  attr_accessor :code_size, :code
  
  def initialize code_size: size
    self.code_size = code_size
    self.code = Match.generate_code code_size
  end
  
  def self.colors 
    [:R,:B,:G,:Y,:O,:P,:C,:M]
  end

  def self.generate_code size
    size.times.map { Match.colors.sample 1 }
  end

  def parse_guess guess
    exact_near_map = map_code_to_guess guess

    {exact: exact_near_map.count(:exact), near: exact_near_map.count(:near)}
  end

  private
  def map_code_to_guess guess 
    self.code.each_with_index.map do |code_color, code_index|
      index = guess.index code_color
      case 
      when index == code_index
        guess[index] = nil
        :exact
      when index != nil
        :near
      else
        :miss
      end
    end
  end

end