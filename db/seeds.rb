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
    email: "#{username}@caramail.com",
    password: "password"
  )
end
puts "Created #{User.count} users!"

# Projects
keyword_array = ["creative", "tech", "practical", "academic", "lifestyle", "social"]
keyword_array2 = ["easy", "fun", "intense", "moderate"]
puts 'Creating projects...'
@users = User.where.not(id: rob.id)
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
proj1pic = File.open('app/assets/images/nail.png')
# URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj1.photo.attach(io: proj1pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj2 = Project.create!(
  title: "Beginner's Yoga",
  user: @users.sample,
  description: "Yoga is a great way to focus your body and mind. In these videos I will show you some basic yoga stances that you can practice at home.",
  tag_list: ["lifestyle", "moderate"],
  published: true
)
search_word = proj2[:title]
proj2pic = File.open('app/assets/images/yoga.jpg')
proj2.photo.attach(io: proj2pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

personal_web = Project.create!(
  title: "Personal Webpage",
  user: ver,
  esttime: "1 week",
  description: "I will show you how to make a simple webpage using HTML and CSS, and some free places to hostit online!",
  tag_list: ["academic", "tech", "moderate"],
  published: true
)
search_word = "pc"
personal_webpic = File.open('app/assets/images/pc.jpg')
personal_web.photo.attach(io: personal_webpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")


puts 'creating steps for personal website...'



headers = [nil, "Find a host", "Decide on the content", "Create a logo", "Create pages", "Publish", "Update"]

descriptions = [nil,
  "The host is the company that will store the files that make up your website. Whether it's free or paid, you'll need to set up an account first.",
  "You know this is a website for your friends and family, so think about what you will offer them when they visit. Some great ideas are tools like photo galleries, a calendar, a guest-book or forum, an e-mail list, and news on your front-page. Write down your thoughts as you come up with what to include.",
  "Use a program like Corel Paint Shop Pro to manipulate some text (possibly your name or family name) into an attractive and pleasing design. You could just save yourself the money and look for some open source software, gimp or inkscape should do just fine. They are also free and just as useful as Photoshop and Paint.",
  'Using HTML or a Web-Publishing tool like Macromedia Dreamweaver, create a "Home" page with an introduction to the website, news, and basic instructions on how to navigate it. Other pages such as a "Biography" page and a "Contact" page may soon follow. Save the pages as .html.',
  'Upload your pages and files to your root folder ("/"). Use an FTP program or your web browser to log in to the server. On your browser\'s address bar type "ftp://your-domain-name.com" and hit "Go" or the Enter key, then fill out the prompt with your username and password (provided by your host). You can browse your folders as you would on your PC or Mac.',
  'Keeping your family and friends up-to-date with news and photos is invaluable to them. Share new stories and jokes with them frequently to keep them coming back.'
]
pics = [
  nil,
  'app/assets/images/findhost.png',
  'app/assets/images/content.jpg',
  'app/assets/images/logo.jpg',
  'app/assets/images/pages.jpeg',
  'app/assets/images/publish.jpg',
  'app/assets/images/update.jpg'
]

step1 = ProjectStep.create!(
  project: personal_web,
  ordinal: 1,
  header: "Find a host",
  description: "The host is the company that will store the files that make up your website. Whether it's free or paid, you'll need to set up an account first."
)
  pic = File.open('app/assets/images/findhost.png')
  step1.photo.attach(io: pic, filename: "#{headers[1]}", content_type: 'image/jpg')

step2 = ProjectStep.create!(
  project: personal_web,
  ordinal: 2,
  header: "Decide on the content",
  description: "You know this is a website for your friends and family, so think about what you will offer them when they visit. Some great ideas are tools like photo galleries, a calendar, a guest-book or forum, an e-mail list, and news on your front-page. Write down your thoughts as you come up with what to include."
)
  pic = File.open('app/assets/images/content.jpg')
  step2.photo.attach(io: pic, filename: "#{headers[2]}", content_type: 'image/jpg')

step3 = ProjectStep.create!(
  project: personal_web,
  ordinal: 3,
  header: "Create a logo",
  description: descriptions[3]
)
  pic = File.open(pics[3])
  step3.photo.attach(io: pic, filename: "#{headers[3]}", content_type: 'image/jpg')

step4 = ProjectStep.create!(
  project: personal_web,
  ordinal: 4,
  header: headers[4],
  description: descriptions[4]
)
  pic = File.open(pics[4])
  step4.photo.attach(io: pic, filename: "#{headers[4]}", content_type: 'image/jpg')

step5 = ProjectStep.create!(
  project: personal_web,
  ordinal: 5,
  header: headers[5],
  description: descriptions[5]
)
  pic = File.open(pics[5])
  step5.photo.attach(io: pic, filename: "#{headers[5]}", content_type: 'image/jpg')


step6 = ProjectStep.create!(
  project: personal_web,
  ordinal: 6,
  header: headers[6],
  description: descriptions[6]
)
  pic = File.open(pics[6])
  step6.photo.attach(io: pic, filename: "#{headers[6]}", content_type: 'image/jpg')

puts "#{ProjectStep.where(project: personal_web).count} steps created for personal webpage"















proj4 = Project.create!(
  title: "Start a YouTube Channel",
  user: @users.sample,
  description: "Making YouTube videos is really fun! In this project you can learn video editing and simple camerawork so that you can start making your own YouTube videos. Share what you love with the world!",
  tag_list: ["lifestyle", "tech", "intense"],
  published: true
)
search_word = proj4[:title]
proj4pic = File.open('app/assets/images/youtube.jpg')
proj4.photo.attach(io: proj4pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj5 = Project.create!(
  title: "Design a Boardgame",
  user: @users.sample,
  description: "Boardgames are fun to play, but also fun to make! This project takes you step-by-step from concept to playtesting. Please check my other project about publishing a boardgame if you want to go further!",
  tag_list: ["social", "creative", "fun"],
  published: true
)
search_word = proj5[:title]
proj5pic = File.open('app/assets/images/boardgame.jpg')
proj5.photo.attach(io: proj5pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj6 = Project.create!(
  title: "Stop-Motion Animation",
  user: @users.sample,
  description: "You don't need lots of artists and equipment to make your own animation! Stop-motion is a fun way to express your creativity, and can be done with a regular digital camera.",
  tag_list: ["practical", "creative", "tech", "intense"],
  published: true
)
search_word = proj6[:title]
proj6pic = File.open('app/assets/images/stopmotion.jpeg')
proj6.photo.attach(io: proj6pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj7 = Project.create!(
  title: "Become a 'Local Guide' on Google",
  user: @users.sample,
  description: "'Local Guides' are people who review interesting places around their area on Google Maps. It's a fun way to get in the habit of writing more, and you will be able to share your unique experiences with others all over the world!",
  tag_list: ["practical", "lifestyle", "fun"],
  published: true
)
search_word = proj7[:title]
proj7pic = File.open('app/assets/images/localguide.jpg')
proj7.photo.attach(io: proj7pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj8 = Project.create!(
  title: "Mindful Meditation",
  user: @users.sample,
  description: "Meditation seems easy but is actualy a challenge! It's a good way to balance your emotions and clear your thoughts. It helps with focus and attention. ",
  tag_list: ["lifestyle", "easy"],
  published: true
)
search_word = proj8[:title]
proj8pic = File.open('app/assets/images/meditation.jpg')
proj8.photo.attach(io: proj8pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

proj9 = Project.create!(
  title: "Make your own Earrings",
  user: @users.sample,
  description: "Jewelry is supposed to show your own style, so the best way to find the ones you want is to make them yourself! I will show you how to make your own earrings out of cheap materials you can easily buy from the internet!",
  tag_list: ["lifestyle", "creative", "fun"],
  published: true
)
search_word = proj9[:title]
proj9pic = File.open('app/assets/images/earring.png')
# URI.open("https://source.unsplash.com/featured/?#{search_word}")
proj9.photo.attach(io: proj9pic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

projX = Project.create!(
  title: "Mood Board",
  user: @users.sample,
  description: "Mood boards can help give you encouragement and motivation, and cheer you up! It's really fun and easy to do.",
  tag_list: ["creative", "fun"],
  published: true
)
search_word = projX[:title]
projXpic = File.open('app/assets/images/moodboard.jpg')
projX.photo.attach(io: projXpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

projXI = Project.create!(
  title: "Halloween Makeup",
  user: @users.sample,
  description: "Surprise your friends and family with a shocking new face! We canuse some simple tricks from Hollywood makeup artists to make impressive and grotesque designs.",
  tag_list: ["creative", "fun"],
  published: true
)
search_word = projXI[:title]
projXIpic = File.open('app/assets/images/halloween.jpg')
projXI.photo.attach(io: projXIpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

projXII = Project.create!(
  title: "Build a PC",
  user: @users.sample,
  description: "Make your own PC in this project. We can make the computer that we really want. It is not too difficult, like lego.",
  tag_list: ["tech", "practical", "moderate"],
  published: true
)
search_word = projXII[:title]
projXIIpic = File.open('app/assets/images/pc.jpg')
projXII.photo.attach(io: projXIIpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")

projXIII = Project.create!(
  title: "Edit Wikipedia",
  user: @users.sample,
  description: "You can share your knowledge and help others! Wikipedia always needs volunteer editors to make sure the information is correct and current. If you are passionate about something you can let other people know about it on Wikipedia!",
  tag_list: ["academic", "easy"],
  published: true
)
search_word = projXIII[:title]
projXIIIpic = File.open('app/assets/images/wiki.jpg')
projXIII.photo.attach(io: projXIIIpic, filename: "#{search_word.split(' ').first}.jpg", content_type: "#{search_word.split(' ').first}/jpg")


# BASIL EXAMPLEßß
basil = Project.create!(
  title: "Grow Basil",
  user: moe,
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


# PESTO

pesto = Project.create!(
  title: "Home-made Pesto",
  user: rob,
  esttime: "1 day",
  tag_list: ["practical", "easy"],
  published: false,
  description: "Pesto is a delicious, versatile sauce from the Mediterranean made form basil. I grew lots of basil from Moe's project - so much that I didn't know what to do with it all! I found a few recipes for pesto online and ried it a few times. This is the best version of making pesto that I could come up with. I gave it out to my friends and family and they love it! It goes well with pasta, on toast, or even just as a dip."
)
pestopic = URI.open('https://sweetpeaskitchen.com/wp-content/uploads/2019/11/homemade-pesto-sauce-recipe-a4.jpg')
pesto.photo.attach(io: pestopic, filename: 'basil.jpg', content_type: 'image/jpg')

p1 = ProjectStep.create!(
  project: pesto,
  ordinal: 1,
  header: "Gather your ingredients",
  description: "You will need basil (of course), pine-nuts, parmesan, and olive oil - plus a little salt and pepper. The ratio for ingrediaents takes some practice - if you're growing your own basil then it will be hard to measure. I found that one bunch of basil (pictured) should have about 50g each of pine-nuts and parmesan, 2 cloves of garlic, and 150ml of olive oil. You can try using walnuts instead of pine-nuts if they are too diffiuclt to find."
)
ppic1 = URI.open('https://cdn.shopify.com/s/files/1/2529/4110/products/organic_energy_vegetable_L1060645__02753.jpg?v=1512386553')
p1.photo.attach(io: ppic1, filename: 'pesto1.jpg', content_type: 'image/jpg')

p2 = ProjectStep.create!(
  project: pesto,
  ordinal: 2,
  header: "Toast the pine-nuts",
  description: "Toss the nuts in a hot pan for a few minutes, until golden."
)
ppic2 = URI.open('https://www.finecooking.com/app/uploads/cms/uploadedimages/images/cooking/articles/issues_21-30/fca30st46-01_xlg.jpg')
p2.photo.attach(io: ppic2, filename: 'pesto2.jpg', content_type: 'image/jpg')

p3 = ProjectStep.create!(
  project: pesto,
  ordinal: 3,
  header: "Blend the ingredients.",
  description: "Put all of your ingredients in a blender and pulse them until they are coarse. Don't make it too smooth! You might need to scrape the sides of the blender halfway through."
)
ppic3 = URI.open('https://www.ohnuts.com/blog/pesto-recipe-14.jpg')
p3.photo.attach(io: ppic3, filename: 'pesto3.jpg', content_type: 'image/jpg')

p4 = ProjectStep.create!(
  project: pesto,
  ordinal: 4,
  header: "Add seasoning",
  description: "Add salt and pepper to taste. I like quite a lot of pepper! I find it's also really nice to add a squeeze of lemon juice at this point, but you don't have to."
)
ppic4 = URI.open('https://thesaltymarshmallow.com/wp-content/uploads/2018/04/pesto-recipe6-500x375.jpg')
p4.photo.attach(io: ppic4, filename: 'pesto4.jpg', content_type: 'image/jpg')

p5 = ProjectStep.create!(
  project: pesto,
  ordinal: 5,
  header: "Store for later",
  description: "Put the pesto in a jar and cover with a thin layer of olive oil. It will keep up to a week this way. Remember to put another layer of oil on top after you use some! A good trick is to put the pesto in an icecube tray and freeze it. This keeps for about a month, and is easy to use the right amout in your cooking."
)
ppic5 = URI.open('https://s3.amazonaws.com/finecooking.s3.tauntonclud.com/app/uploads/2017/05/11135009/pesto.jpg')
p5.photo.attach(io: ppic5, filename: 'pesto1.jpg', content_type: 'image/jpg')

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

basrev1 = Review.create!(
  user: User.where.not(id: basil.user.id).sample,
  project: basil,
  rating: rand(3..5),
  content: "I was surprised how easy it was to grow basil! I gave lots to my grandma and she loves it."
)

basrev2 = Review.create!(
  user: User.where.not(id: basil.user.id).sample,
  project: basil,
  rating: rand(3..4),
  content: "I found it really difficult, and the first time I tried they didn't grow. Be careful not to leave them somewhere too hot! After I learned that, my second try was successful."
)

basrev3 = Review.create!(
  user: User.where.not(id: basil.user.id).sample,
  project: basil,
  rating: rand(4..5),
  content: "The basil is so tasty! My mother uses it in her cooking a lot, and she wants me to grow more herbs ;^_^"
)

webrev1 = Review.create!(
  user: User.where.not(id: personal_web.user.id).sample,
  project: personal_web,
  rating: rand(2..4),
  content: "I found it quite difficult, so I needed to look at YouTube videos to help me."
)

webrev2 = Review.create!(
  user: User.where.not(id: personal_web.user.id).sample,
  project: personal_web,
  rating: rand(3..5),
  content: "I learned HTML before, but I didn't know about CSS, so this was a good project. At the end I could make a great website for my cat pictures."
)

webrev3 = Review.create!(
  user: User.where.not(id: personal_web.user.id).sample,
  project: personal_web,
  rating: rand(4..5),
  content: "Have a look at the website I made: http://www.animepowerhour.club"
)

# Project.all.each do |project|
#   rand(1..5).times do
#     review = Review.create!(
#       user: User.where.not(id: project.user.id).sample,
#       content: Faker::Restaurant.review,
#       rating: rand(1..5),
#       project: project
#     )
#     # review_photo = URI.open("https://source.unsplash.com/featured/?#{project.title}")
#     # review.photo.attach(io: review_photo, filename: "review_#{project.title.split(' ').first}.jpg", content_type: 'image/jpg') if rand(5).even?
#   end
# end

# Complited projects for Rob
puts 'Creating complited user_projects forr rob...'
rob = User.find_by(username: "Rob")
pc_rob = UserProject.create!(
  project: projX,
  user: rob,
  completed: true,
  last_completed: projX.project_steps.count
  )

wiki_rob = UserProject.create!(
  project: proj8,
  user: rob,
  completed: true,
  last_completed: proj8.project_steps.count
  )

stopmotion_rob = UserProject.create!(
  project: proj6,
  user: rob,
  completed: true,
  last_completed: proj6.project_steps.count
  )
basil_rob = UserProject.create!(
  project: basil,
  user: rob,
  completed: false,
  last_completed: 4
  )
puts "created #{Review.count} reviews"

puts "Seeding messages"

m1 = Message.create!(
  content: "hahahaha yeah I agree",
  user: @users.sample,
  created_at: Time.now,
  project: basil
  )
m2 = Message.create!(
  content: "lol",
  user: @users.sample,
  created_at: Time.now,
  project: basil
  )
m3 = Message.create!(
  content: "did you try keeping them out of direct sunlight?",
  user: @users.sample,
  created_at: Time.now,
  project: basil
  )
m4 = Message.create!(
  content: "no, they were in my window the whole time",
  user: @users.sample,
  created_at: Time.now,
  project: basil
  )
m5 = Message.create!(
  content: "ah that's probably why",
  user: @users.sample,
  created_at: Time.now,
  project: basil
  )

mI = Message.create!(
  content: "if you click on 'inspect' you can see it",
  user: @users.sample,
  created_at: Time.now,
  project: personal_web
  )
mII = Message.create!(
  content: "ahhhhh I see. thanks!",
  user: @users.sample,
  created_at: Time.now,
  project: personal_web
  )
mIII = Message.create!(
  content: "np",
  user: @users.sample,
  created_at: Time.now,
  project: personal_web
  )
mIV = Message.create!(
  content: "hey guys I found a great website for color schemes https://www.happyhues.co/",
  user: @users.sample,
  created_at: Time.now,
  project: personal_web
  )
mV = Message.create!(
  content: "wow, great! thanks!!!",
  user: @users.sample,
  created_at: Time.now,
  project: personal_web
  )

puts "#{Message.count} messages seeded."


puts "Seed complete."
