require 'faker'

puts 'Deleting all projects...'
Project.destroy_all
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

puts 'Creating projects...'
@users = User.all
@users.each do |user|
  proj = Project.create!(
    title: Faker::Company.industry,
    user: user,
    description: Faker::Company.bs
  )
  ord = 1
  rand(3..6).times do
    ProjectStep.create!(
      project: proj,
      ordinal: ord,
      description: Faker::Company.bs
    )
    ord += 1
  end
end

puts "#{Project.count} projects created."
puts "Seed complete."
