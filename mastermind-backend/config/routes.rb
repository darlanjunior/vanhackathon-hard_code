Rails.application.routes.draw do
  post '/new_game' => 'match#new_game'
  post '/join_game/:game_key' => 'match#join_game'
  get '/guess/:game_key' => 'match#guess'
end