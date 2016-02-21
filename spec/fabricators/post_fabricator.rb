Fabricator(:post) do
  user
  title { Faker::Name.title }
  description { Faker::Lorem.paragraph }
end