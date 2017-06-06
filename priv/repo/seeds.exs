alias Api.Repo
alias Api.People.Person
alias Api.Content.Rows

# Create 10 seed users

for _ <- 1..10 do
  Repo.insert!(%Person{
    name: Faker.Name.name,
    email: Faker.Internet.safe_email
  })
end

# Create 40 seed posts

for _ <- 1..40 do
  Repo.insert!(%Rows{
    title: Faker.Lorem.sentence,
    body: Faker.Lorem.sentences(%Range{first: 1, last: 3}) |> Enum.join("\n\n"),
    people_id: Enum.random(1..10) # Pick random user for post to belong to
  })
end
