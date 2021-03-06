# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Theater.destroy_all
Review.destroy_all

User.create(first_name: "Admin",
            last_name: "Administrator",
            email: "superpowers@admin.com",
            password: "superpowers",
            role: "admin",
            avatar: Faker::Avatar.image)

User.create(first_name: "Ghost",
            last_name: "Deleted",
            email: "gone@deleted.com",
            password: "nolongerhere",
            avatar: Faker::LoremPixel.image("400x400"))

20.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: Faker::Internet.password,
              avatar: Faker::Avatar.image)
end

15.times do
  Theater.create(name: Faker::Company.name,
                 address: Faker::Address.street_address,
                 city: Faker::Address.city,
                 state: Faker::Address.state,
                 zip: "90210",
                 user: User.all.sample,
                 image: Faker::LoremPixel.image("400x400"))
end

35.times do
  Review.create(rating: Faker::Number.between(1, 5),
                body: Faker::ChuckNorris.fact,
                user: User.all.sample,
                theater: Theater.all.sample)
end
