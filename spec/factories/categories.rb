FactoryBot.define do
  factory :category do
    name { FFaker::InternetSE.user_name_random }
  end
end
