class Game < RedisOrm::Base
  use_uuid_as_id

  belongs_to :match
  has_many :players

  expire 5.minutes.from_now

  def self.code_size
    8
  end

  def initialize player, match
    self.players = [player]
    self.match = match
  end

  def add_player player
    self.players << player

    self.save
  end
end