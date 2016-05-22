FactoryGirl.define do
  factory :user do
    name "Toninho do Diabo"
  end

  factory :user2, class: User do
    name "João Maria"
  end
end
