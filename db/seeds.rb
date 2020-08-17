require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Users
puts "Cleaning users..."
User.destroy_all

puts 'Creating users...'
User.create!(
    username: "Rob",
    email: "rob@caramail.com",
    password: "password"
  )

User.create!(
    username: "Veronica",
    email: "veronica@caramail.com",
    password: "password"
  )

User.create!(
    username: "Moe",
    email: "moe@caramail.com",
    password: "password"
  )

5.times do
    username = Faker::Name.first_name
    next if User.find_by(username: username)

    User.create!(
    username: username,
    email: Faker::Internet.email,
    password: "password"
    )
end

puts "Created #{User.count} users!"

# Projects
# puts 'Deleting all of projects...'
# Project.delete_all

# puts 'Creating projects...'

