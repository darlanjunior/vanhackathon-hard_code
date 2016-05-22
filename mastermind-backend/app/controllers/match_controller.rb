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
        message: e.exception.to_s
      }
    }, :status => 404
  end

  def new_game
    json, status = response_create_game Match.new(users: [User.new(name: game_params)]).tap(&:save)

    render json: json, status: status
  end

  def join_game
    user = User.new(name: game_params)
    user.match = @match

    if user.save
      render json: game_response(@match), status: 200
    else
      render json: {error: {code: 400, message: user.errors.messages }}, status: 400
    end
  end

  def guess
    guess = Guess.new(colors: guess_params[:code], exact: 0, near: 0)
    guess.user = @match.users.where(name: guess_params[:name]).first
    parsed = @match.parse_guess(guess.colors)
    guess.exact = parsed[:exact]
    guess.near = parsed[:near]

    if guess.save 
      if guess.exact == Match.code_size
        response = win_game_response @match.code, (Time.now - @match.created_at), guess.user.name
        
        @match.destroy

        render json: response, status: 200
      else
        render json: guess_response(@match, guess.user, guess), status: 200
      end
    else
      render json: {error: {code: 400, message: guess.errors.messages }}, status: 400
    end

  end

  private
  def set_match
    @match = Match.find(params[:game_key])
  end

  def guess_params
    params.require(:name)
    params.require(:code)
    params.require(:game_key)

    params.permit(:name,:game_key, {code: []})
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

  def guess_response match, user, guess
    {
      colors: Match.colors,
      code_length: Match.code_size,
      game_key: match.id,
      guess: guess.colors,
      num_guesses: user.guesses.count,
      past_results: user.guesses,
      result: guess,
      solved: (guess.exact == Match.code_size)
    }
  end

  def win_game_response code, time, name
    {
      code: code,
      time_taken: time,
      result: "You win!",
      solved: true,
      time_taken: 64.75358,
      user: name
    }
  end

end
