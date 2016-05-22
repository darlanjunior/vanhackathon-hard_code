FactoryGirl.define do
  factory :guess do
    colors ["R","B","G","Y","R","B","G","Y"]
    near 1
    exact 1
  end

  factory :invalid_colors_guess, class: :guess do
    colors ["R","B","a","b","4","B","G","Y"]
    near 1
    exact 1
  end

  factory :non_numeral_guess, class: :guess do
    colors ["R","B","G","Y","R","B","G","Y"]
    near 'a'
    exact 1.4
  end
end
