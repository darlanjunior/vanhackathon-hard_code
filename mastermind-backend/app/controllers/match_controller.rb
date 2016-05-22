class MatchController < ApplicationController
  before_action :set_match, only: [:join_game, :guess]

  rescue_from ActionController::ParameterMissing do |e|
    render json: { 
      error: {
        code: 422,
        message: "Parameter missing: #{e.param}"
      }
    }, :status => 422
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { 
      error: {
        code: 404,
        message: e.exception
      }
    }, :status => 404
  end

  def new_game
    json, status = response_create_game Match.create(name: game_params)

    render json: json, status: status
  end

  def join_game
    @match.add_player game_params

    render json: game_response(@match), status: 200
  end

  def guess
    @user.add_guess @match.match.parse_guess(guess_params)

    render json: guess_response(@match, @user), status: 200
  end

  private
  def set_match
    @match = Match.find(params[:game_key])
  end

  def guess_params
    params.require([:name, :guess, :game_key])
  end

  def game_params
    params.require(:name)
  end

  def response_create_game match
    match.errors.empty? ? 
    [new_game_json(match), 200] : 
    [internal_error_json, 500]
  end

  def internal_error_json
    {
      error: {
        code: 500,
        message: 'Error when creating match'
      }
    }
  end

  def new_game_json match
    {
      colors: Match.colors,
      code_length: Match.code_size,
      game_key: match.id,
      num_guesses: 0,
      past_results: [],
      solved: false 
    }
  end

  def guess_response match, user
    {
      colors: Match.colors,
      code_length: Match.code_size,
      game_key: match.id,
      guess: user.guesses.last.guess,
      num_guesses: user.guesses.count,
      past_results: user.guesses,
      result: user.guesses.last,
      solved: match.match.code == user.guesses.last.guess
    }
  end

end
