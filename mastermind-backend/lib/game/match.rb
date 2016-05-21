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
    { exact: 4, near: 0 }
  end

end