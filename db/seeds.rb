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

# BASIL EXAMPLE
basil = Project.create!(
  title: "Grow Basil",
  user: rob,
  description: "Basil is easy to grow, and transforms ordinary meals into culinary treasures! This project tells you how to plant and harvest basil."
)
baspic = URI.open('https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/266425_2200-1200x628.jpg')
basil.photo.attach(io: baspic, filename: 'basil.jpg', content_type: 'image/jpg')
ProjectStep.create!(
  project: basil,
  ordinal: 1,
  description: "Choose the kind of basil you wish to grow. Basil comes in many different varieties, each of which has a unique flavor and smell. Read up on different types of basil and pick out one - or several - that sounds good to you, then order the seeds or buy them at a garden store."
)
ProjectStep.create!(
  project: basil,
  ordinal: 2,
  description: "Prepare seed containers - yoghurt pots are ideal for this. Fill them with compost and press it down slightly to remove air pockets. Dampen the soil with water."
)
ProjectStep.create!(
  project: basil,
  ordinal: 3,
  description: "Drop one to two seeds into each container. Cover them lightly with soil. Cover containers with clear plastic kitchen wrap, so they stay moist. Leave the containers in a sunny window. Twice daily, remove the plastic wrap and sprinkle the containers with more water."
)
ProjectStep.create!(
  project: basil,
  ordinal: 4,
  description: "Once two sets of leaves have formed, basil can be planted into the garden or permanent containers. Whether you plant them in a pot or the garden, make sure it's large enough to accommodate the number of plants you're growing; they need to be planted 0.3m apart, since they grow quite large."
)
ProjectStep.create!(
  project: basil,
  ordinal: 5,
  description: "As the plant matures, pinch off the top two pairs of leaves once a stalk reaches a reasonable height. If you look closely, at the base of every leaf are two tiny little leaves that will grow outwards if the stem growing between them is cut off. Cut close to those tiny leaves, but be sure not to damage them. This means that your basil plant will grow to be bushy."
)

puts "#{Project.count} projects created."
puts "Seed complete."
