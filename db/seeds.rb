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
50.times do
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
keyword_array = ["creative", "tech", "practical", "academic", "lifestyle", "social"]
keyword_array2 = ["easy", "fun", "intense", "moderate"]
puts 'Creating projects...'
@users = User.all
# 5.times do
#   proj = Project.create!(
#     title: Faker::Company.industry,
#     user: @users.sample,
#     description: Faker::Company.bs,
#     tag_list: [keyword_array.sample, keyword_array2.sample],
#     published: true
#   )
#   serch_word = proj[:title]
#   projpic = URI.open("https://source.unsplash.com/featured/?#{serch_word}")
#   proj.photo.attach(io: projpic, filename: "#{serch_word.split(' ').first}.jpg", content_type: "#{serch_word.split(' ').first}/jpg")
#   ord = 1
#   rand(3..6).times do
#     ProjectStep.create!(
#       project: proj,
#       ordinal: ord,
#       description: Faker::Company.bs
#     )
#     ord += 1
#   end
# end

proj1 = Project.create!(
  title: "Nail Art",
  user: @users.sample,
  description: "Learn how to make your own beautiful nail art. From simple designs to character art, I will show you how!",
  tag_list: ["creative", "lifestyle", "fun"],
  published: true
)
search_word = proj1[:title]
proj1pic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj1.photo.attach(io: proj1pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj2 = Project.create!(
  title: "Beginner's Yoga",
  user: @users.sample,
  description: "Yoga is a great way to focus your body and mind. In these videos I will show you some basic yoga stances that you can practice at home.",
  tag_list: ["lifestyle", "moderate"],
  published: true
)
search_word = proj2[:title]
proj2pic = URI.open("https://source.unsplash.com/featured/?yoga")
proj2.photo.attach(io: proj2pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj3 = Project.create!(
  title: "Personal Webpage",
  user: @users.sample,
  description: "I will show you how to make a simple webpage using HTML and CSS, and some free places to hostit online!",
  tag_list: ["academic", "tech", "moderate"],
  published: true
)
search_word = proj3[:title]
proj3pic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj3.photo.attach(io: proj3pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj4 = Project.create!(
  title: "Start a YouTube Channel",
  user: @users.sample,
  description: "Making YouTube videos is really fun! In this project you can learn video editing and simple camerawork so that you can start making your own YouTube videos. Share what you love with the world!",
  tag_list: ["lifestyle", "tech", "intense"],
  published: true
)
search_word = proj4[:title]
proj4pic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj4.photo.attach(io: proj4pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj5 = Project.create!(
  title: "Design a Boardgame",
  user: @users.sample,
  description: "Boardgames are fun to play, but also fun to make! This project takes you step-by-step from concept to playtesting. Please check my other project about publishing a boardgame if you want to go further!",
  tag_list: ["social", "creative", "fun"],
  published: true
)
search_word = proj5[:title]
proj5pic = URI.open("https://source.unsplash.com/featured/?boardgame")
proj5.photo.attach(io: proj5pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj6 = Project.create!(
  title: "Stop-Motion Animation",
  user: @users.sample,
  description: "You don't need lots of artists and equipment to make your own animation! Stop-motion is a fun way to express your creativity, and can be done with a regular digital camera.",
  tag_list: ["practical", "creative", "tech", "intense"],
  published: true
)
search_word = proj6[:title]
proj6pic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj6.photo.attach(io: proj6pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj7 = Project.create!(
  title: "Become a 'Local Guide' on Google",
  user: @users.sample,
  description: "'Local Guides' are people who review interesting places around their area on Google Maps. It's a fun way to get in the habit of writing more, and you will be able to share your unique experiences with others all over the world!",
  tag_list: ["practical", "lifestyle", "fun"],
  published: true
)
search_word = proj7[:title]
proj7pic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj7.photo.attach(io: proj7pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj8 = Project.create!(
  title: "Mindful Meditation",
  user: @users.sample,
  description: "Meditation seems easy but is actualy a challenge! It's a good way to balance your emotions and clear your thoughts. It helps with focus and attention. ",
  tag_list: ["lifestyle", "easy"],
  published: true
)
search_word = proj8[:title]
proj8pic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj8.photo.attach(io: proj8pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj9 = Project.create!(
  title: "Make your own Earrings",
  user: @users.sample,
  description: "Jewelry is supposed to show your own style, so the best way to find the ones you want is to make them yourself! I will show you how to make your own earrings out of cheap materials you can easily buy from the internet!",
  tag_list: ["lifestyle", "creative", "fun"],
  published: true
)
search_word = proj9[:title]
proj9pic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj9.photo.attach(io: proj9pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

projX = Project.create!(
  title: "Mood Board",
  user: @users.sample,
  description: "Mood boards can help give you encouragement and motivation, and cheer you up! It's really fun and easy to do.",
  tag_list: ["creative", "fun"],
  published: true
)
search_word = projX[:title]
projXpic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
projX.photo.attach(io: projXpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

projXI = Project.create!(
  title: "Halloween Makeup",
  user: @users.sample,
  description: "Surprise your friends and family with a shocking new face! We canuse some simple tricks from Hollywood makeup artists to make impressive and grotesque designs.",
  tag_list: ["creative", "fun"],
  published: true
)
search_word = projXI[:title]
projXIpic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
projXI.photo.attach(io: projXIpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

projXII = Project.create!(
  title: "Build a PC",
  user: @users.sample,
  description: "Make your own PC in this project. We can make the computer that we really want. It is not too difficult, like lego.",
  tag_list: ["tech", "practical", "moderate"],
  published: true
)
search_word = projXII[:title]
projXIIpic = URI.open("https://source.unsplash.com/featured/?desktop")
projXII.photo.attach(io: projXIIpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

projXIII = Project.create!(
  title: "Edit Wikipedia",
  user: @users.sample,
  description: "You can share your knowledge and help others! Wikipedia always needs volunteer editors to make sure the information is correct and current. If you are passionate about something you can let other people know about it on Wikipedia!",
  tag_list: ["academic", "easy"],
  published: true
)
search_word = projXIII[:title]
projXIIIpic = URI.open("https://source.unsplash.com/featured/?#{search_word}")
projXIII.photo.attach(io: projXIIIpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")


# BASIL EXAMPLE
basil = Project.create!(
  title: "Grow Basil",
  user: rob,
  esttime: "2 weeks",
  tag_list: ["practical", "easy"],
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
  rand(1..5).times do
    review = Review.create!(
      user: User.where.not(id: project.user.id).sample,
      content: Faker::Restaurant.review,
      rating: rand(1..5),
      project: project
    )
    # review_photo = URI.open("https://source.unsplash.com/featured/?#{project.title}")
    # review.photo.attach(io: review_photo, filename: "review_#{project.title.split(' ').first}.jpg", content_type: 'image/jpg') if rand(5).even?
  end
end
puts "created #{Review.count} reviews"


puts "Seed complete."
