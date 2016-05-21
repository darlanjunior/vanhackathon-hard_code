Rails.application.routes.draw do
  post '/new_game' => 'game#new_game'
  post '/join_game/:game_key' => 'game#join_game'
  get '/guess/:game_key' => 'game#guess'
end