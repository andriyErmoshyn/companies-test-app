p 'Deleting data before seeding'

Company.delete_all
Branch.delete_all

p 'Creating new data'

100.times do
  company = Company.create(
      name: Faker::Company.name,
      description: Faker::Lorem.sentences(number: 1).join,
      address: Faker::Address.full_address
  )

  next unless company.valid?

  rand(1..3).times do
    company.branches.create(
        number: Faker::Number.number(digits: 6),
        area: Faker::Address.state
    )
  end
rescue => e
  p e
  next
end
