FactoryGirl.define do
  factory :user do
    association :players, factory: :user, name: '{ name }'
    game_key 'valid_game_key'
  end
end
