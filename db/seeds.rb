require 'faker'
require 'open-uri'

moepic = URI.open('https://avatars1.githubusercontent.com/u/64414386?v=4')
robpic = URI.open('https://avatars2.githubusercontent.com/u/66347766?v=4')
verpic = URI.open('https://avatars0.githubusercontent.com/u/65526708?v=4')
yanpic = URI.open('https://avatars1.githubusercontent.com/u/26819547?v=4')

puts 'Deleting all projects...'
Project.destroy_all
puts "Cleaning users..."
User.destroy_all

puts 'Creating users...'
rob = User.create!(
  username: "Rob",
  email: "rob@caramail.com",
  password: "password"
)
rob.photo.attach(io: robpic, filename: 'rob.jpeg', content_type: 'image/jpeg')

ver = User.create!(
  username: "Veronica",
  email: "veronica@caramail.com",
  password: "password"
)
ver.photo.attach(io: yanpic, filename: 'ver.jpeg', content_type: 'image/jpeg')

moe = User.create!(
  username: "Moe",
  email: "moe@caramail.com",
  password: "password"
)
moe.photo.attach(io: moepic, filename: 'moe.jpeg', content_type: 'image/jpeg')

5.times do
  username = Faker::Name.first_name
  next if User.find_by(username: username)

  user = User.create!(
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
