class GamesController < ApplicationController

  # returns the landing page to start a game
  def new
  end

  # for now, we are returning user, sorry
  def create
    @game = [
      user: params[:user],
      colors: ['R','B','G','Y','O','P','C','M'],
      code_length: 8,
      game_key: 'game_key',
      num_guesses: 0,
      past_results: [],
      solved: false
    ]
    render plain: @game.inspect
  end

end
