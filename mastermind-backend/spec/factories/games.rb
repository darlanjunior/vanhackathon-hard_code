FactoryGirl.define do
  factory :single_player_game, class: Game do
    game_key 'valid_game_key'
    association :match, factory: :match 
    association :players, factory: :user, name: '{ name }'
  end
=begin
factory :multiplayer_game, class: Game do
    game_key 'valid_game_key'
    association :match, factory: :match 

    factory :game_with_players do 
      transient do 
        players_count 2
      end

      #after(:create) do |game, evaluator|
        #create_list :user, evaluator.players_count, game: game
      #end
    end
  end
=end
end
