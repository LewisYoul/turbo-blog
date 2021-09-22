FactoryBot.define do
  factory :post do
    title { 'Original Title' }
    summary { 'Original Summary' }
    body { 'Original Body' }
  end

  factory :tag do
    name { 'Ruby on Rails' }
  end
end