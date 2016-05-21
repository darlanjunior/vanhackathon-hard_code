class Guess < RedisOrm::Base 
  property :guess, Array
  property :exact, Integer
  property :near, Integer

  validates :guess, presence: true, length: {is: Game.code_size}
  validate :guess_contents

  private
  def guess_contents
    errors.add(:guess, 'Invalid content format') if self.guess && !self.guess.all? {|color| Match.colors.include? color}
  end
end