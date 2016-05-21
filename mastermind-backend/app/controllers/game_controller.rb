class GameController < ApplicationController
  def new_game
    if !new_game_params['name']
      render json: { errors: 'A player name is required' }, status: 422
    else
      render json: { game_key: "#{Random.rand}" }
    end
  end

  def join_game
    render json: {}
  end

  def guess
    render json: {}
  end

  private
  def new_game_params
    params.permit(:name)
  end
end
