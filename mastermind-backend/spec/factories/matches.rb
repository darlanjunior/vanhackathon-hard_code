FactoryGirl.define do
  factory :match do
    id 777
    code ["R","B","G","Y","R","B","G","Y"]
  end

  factory :match2, class: Match do
    id 778
    code ["R","B","G","Y","R","B","G","Y"]
  end
end