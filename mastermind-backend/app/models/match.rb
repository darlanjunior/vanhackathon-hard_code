class Match < ActiveRecord::Base
  has_many :users, dependent: :destroy
  serialize :code, Array
  
  after_initialize :set_code

  def code
    @code ? @code.split('') : nil
  end

  def code= code
    @code = code.join
  end

  def set_code
    self.code ||= Match.generate_code(Match.code_size)
  end

  def self.code_size
    8
  end
  
  def self.colors 
    ["R","B","G","Y","O","P","C","M"]
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
    # this is reeeally ugly
    copy = []
    guess.each {|g| copy << g}

    self.code.each_with_index.map do |code_color, code_index|
      case 
      when copy[code_index] == code_color
        copy[code_index] = nil
        :exact
      when copy.index(code_color)
        :near
      else
        :miss
      end
    end
  end

end