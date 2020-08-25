require 'faker'
require 'open-uri'
require 'json'
moepic = URI.open('https://avatars1.githubusercontent.com/u/64414386?v=4')
robpic = URI.open('https://avatars2.githubusercontent.com/u/66347766?v=4')
verpic = URI.open('https://avatars0.githubusercontent.com/u/65526708?v=4')
yanpic = URI.open('https://avatars1.githubusercontent.com/u/26819547?v=4')

puts 'Deleting all reviews...'
Review.destroy_all
puts 'Deleting all user_projects and projects...'
UserProject.destroy_all
Project.destroy_all
puts "Cleaning users..."
User.destroy_all

# USERS
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
keyword_array = ["plant", "math", "logic", "art", "coding"]
keyword_array2 = ["easy", "fun", "intense"]
puts 'Creating projects...'
@users = User.all
@users.each do |user|
  proj = Project.create!(
    title: Faker::Company.industry,
    user: user,
    description: Faker::Company.bs,
    tag_list: [keyword_array.sample, keyword_array2.sample],
    published: true
  )
  serch_word = proj[:title]
  projpic = URI.open("https://source.unsplash.com/featured/?#{serch_word}")
  proj.photo.attach(io: projpic, filename: "#{serch_word.split(' ').first}.jpg", content_type: "#{serch_word.split(' ').first}/jpg")
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
  user: ver,
  published: true,
  description: "Basil is easy to grow, and transforms ordinary meals into culinary treasures! This project tells you how to plant and harvest basil."
)
baspic = URI.open('https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/266425_2200-1200x628.jpg')
basil.photo.attach(io: baspic, filename: 'basil.jpg', content_type: 'image/jpg')
s1 = ProjectStep.create!(
  project: basil,
  ordinal: 1,
  header: "Select the right seeds",
  description: "Choose the kind of basil you wish to grow. Basil comes in many different varieties, each of which has a unique flavor and smell. Read up on different types of basil and pick out one - or several - that sounds good to you, then order the seeds or buy them at a garden store."
)
pic1 = URI.open('https://images-na.ssl-images-amazon.com/images/I/51NzBAQS8DL.jpg')
s1.photo.attach(io: pic1, filename: 'seeds.jpg', content_type: 'image/jpg')
s2 = ProjectStep.create!(
  project: basil,
  ordinal: 2,
  header: "The right container",
  description: "Prepare seed containers - yoghurt pots are ideal for this. Fill them with compost and press it down slightly to remove air pockets. Dampen the soil with water."
)
pic2 = URI.open('https://cdn.ecommercedns.uk/files/5/224895/9/8050089/little-leggy-plant-pot-4.jpg')
s2.photo.attach(io: pic2, filename: 'pot.jpg', content_type: 'image/jpg')
s3 = ProjectStep.create!(
  project: basil,
  ordinal: 3,
  header: "Plant the seeds",
  description: "Drop one to two seeds into each container. Cover them lightly with soil. Cover containers with clear plastic kitchen wrap, so they stay moist. Leave the containers in a sunny window. Twice daily, remove the plastic wrap and sprinkle the containers with more water."
)
pic3 = URI.open('https://img2.lrgarden.com/feed_pic/87/41/1000318039_1000013406_1503392617.jpg')
s3.photo.attach(io: pic3, filename: 'plant.jpg', content_type: 'image/jpg')
s4 = ProjectStep.create!(
  project: basil,
  ordinal: 4,
  header: "Replanting",
  description: "Once two sets of leaves have formed, basil can be planted into the garden or permanent containers. Whether you plant them in a pot or the garden, make sure it's large enough to accommodate the number of plants you're growing; they need to be planted 0.3m apart, since they grow quite large."
)
pic4 = URI.open('https://steptohealth.com/wp-content/uploads/2019/05/transplanting.jpg')
s4.photo.attach(io: pic4, filename: 'replant.jpg', content_type: 'image/jpg')
s5 = ProjectStep.create!(
  project: basil,
  ordinal: 5,
  header: "Pruning",
  description: "As the plant matures, pinch off the top two pairs of leaves once a stalk reaches a reasonable height. If you look closely, at the base of every leaf are two tiny little leaves that will grow outwards if the stem growing between them is cut off. Cut close to those tiny leaves, but be sure not to damage them. This means that your basil plant will grow to be bushy."
)
pic5 = URI.open('https://i.ytimg.com/vi/PrLWG_w2GHg/maxresdefault.jpg')
s5.photo.attach(io: pic5, filename: 'trim.jpg', content_type: 'image/jpg')
puts "#{Project.count} projects created."

# QUOTE
puts 'Deleting all quotes...'
Quote.destroy_all
puts 'Creating quotes...'
quotes_url = "https://gist.githubusercontent.com/nasrulhazim/54b659e43b1035215cd0ba1d4577ee80/raw/e3c6895ce42069f0ee7e991229064f167fe8ccdc/quotes.json"
buffer = open(quotes_url).read
quote_hashes = JSON.parse(buffer)["quotes"]
# quote_hashes -- array of hashes
quote_hashes.each do |quote_hash|
  Quote.create!(
    content: quote_hash["quote"],
    person: quote_hash["author"]
  )
end
puts "created #{Quote.count} quotes"

# REVIEW
puts 'Creating reviews...'

Project.all.each do |project|
  rand(5).times do
    review = Review.create!(
      user: User.where.not(id: project.user.id).sample,
      content: Faker::Restaurant.review,
      rating: rand(1..5),
      project: project
    )
    review_photo = URI.open("https://source.unsplash.com/featured/?#{project.title}")
    review.photo.attach(io: review_photo, filename: "review_#{project.title.split(' ').first}.jpg", content_type: 'image/jpg') if rand(5).even?
  end
end
puts "created #{Review.count} reviews"


puts "Seed complete."
