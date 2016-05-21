class Match
  attr_accessor :code_size, :code
  
  def initialize code_size: size
    this.code_size = size
    this.code = Match.generate_code size
  end
  
  def self.colors 
    [:R,:B,:G,:Y,:O,:P,:C,:M]
  end

  def self.generate_code code_size
    code_size.times.map { Match.colors.sample }
  end

end