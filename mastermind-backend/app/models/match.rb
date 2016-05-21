class Match < RedisOrm::Base
  property :code_size, Integer
  property :code, Array
  
  def initialize code_size: size
    self.code_size = code_size
    self.code = Match.generate_code code_size
  end
  
  def self.colors 
    [:R,:B,:G,:Y,:O,:P,:C,:M]
  end

  def self.generate_code size
    size.times.map { Match.colors.sample }
  end

  def parse_guess guess
    reduce_guess_map(map_code_to_guess guess)
  end

  private
  def reduce_guess_map exact_near_map
    { exact: exact_near_map.count(:exact), near: exact_near_map.count(:near) }
  end

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