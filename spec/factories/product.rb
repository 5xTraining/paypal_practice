FactoryBot.define do
  factory :product do
    title { Faker::Name.name }
    price { Faker::Number.within(range: 1..100) }
    cover { Faker::LoremFlickr.image(size: "300x300", search_terms: ['cat']) }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
