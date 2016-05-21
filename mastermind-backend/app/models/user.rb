class User < RedisOrm::Base
  property :name, String
  index :name, :unique 
 
  has_many :guesses

  def initialize name
    self.name = name
    self.guesses = []
  end

  def add_guess guess
    self.guesses << guess 

    self.save
  end

end