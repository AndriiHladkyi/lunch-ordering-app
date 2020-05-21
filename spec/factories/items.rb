FactoryBot.define do
  factory :item do
    title { FFaker::Food.meat }
    price { rand(5..100) }
    date  { Date.today }
    image { FFaker::Image.file }
  end
end
