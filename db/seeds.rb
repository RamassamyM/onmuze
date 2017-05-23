# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Cleaning database
print "Destroying proposals...."
Proposal.destroy_all
puts "done"
print "Destroying events...."
Event.destroy_all
puts "done"
print "Destroying performances...."
Performance.destroy_all
puts "done"
print "Destroying places...."
Place.destroy_all
puts "done"
print "Destroying users...."
User.destroy_all
puts "done"

# Adding data

# Creating 2 users for demo
print "Creating 2 users ...."
users = [
  {
    email: 'organizer@onmuze.com',
    password: '12345678'
  },
  {
    email: 'artist@onmuze.com',
    password: '12345678'
  }
]
users.each do |user|
  new_user = User.new(user)
  new_user.save!
end
puts "done"

# Creating a bar for organizer user
print "Creating a bar for organizer@onmuze.com......"

#upload photo banner on cloudinary :
url = "https://scontent-cdg2-1.xx.fbcdn.net/v/t1.0-9/13754227_648073908693454_4697143827883023656_n.jpg?oh=14ef347236c454b570af07ee082e00b6&oe=59A39F9D"
bar = {
  name: "L\'Antidote",
  address: "13bis rue Elie Gentrac",
  description: "L'Antidote vous propose : bar, repas, évènements culturels en tous genre, programmation musicale éclectique."
}
new_place = Place.new(bar)
new_place.user = User.first
# new_place.photo_url = url
new_place.save!
puts "done"

# Creating 2 events for the bar
print "Creating events for a place......"
event_photo_urls = [
  "https://static.pexels.com/photos/196652/pexels-photo-196652.jpeg",
  "https://static.pexels.com/photos/169594/pexels-photo-169594.jpeg",
]
events = [
  {
    name: "Sun Night",
    description: "Tonight come and dance with amazing latin bands for our famous Sun night",
    scheduled_at: Date.parse("03/06/2017")
  },
  {
    name: "Electro Diving Party",
    description: "Th best french Electro Djs on the Bordeaux scene will make you rock all night long!",
    scheduled_at: Date.parse("04/06/2017")
  }
]

events.each_with_index do |event, index|
  new_event = Event.new(event)
  new_event.place = Place.first
  # new_event.photo_url = event_photo_urls[index]
  new_event.save!
end

puts "done"

# Creating genres
print "Seeding genres with event_types........."
genres = {
  "Show" => ["Standup", "Impro"],
  "Music" => ["African", "Latin", "Asian" "Jazz", "Blues", "Disco", "Funk", "Classical", "Pop", "Rock", "House", "Techno"],
  "Dance" => ["African", "Asian", "Contempory", "Modern Jazz", "Classical"],
  "Magic" => ["Magic"],
  "Performance" => ["Fireworks", "Fire shows", "Street show"],
  "Exhibition" => ["Paintings", "Photos", "Scultptures", "Stree Art", "Body Art"]
}
genres.each do |key, value|
  value.each do |genre_name|
    genre = Genre.new(name: genre_name, event_type: key)
    genre.save!
  end
end
puts "done"

# Creating demo performance
print "Seeding demo performance with snawt........"
demo_performance = {
  name: "Snawt",
  description: "Let's Snawt Tonight : \nCréé en 2011, Snawt (Funk/Soul/Pop) est bien décidé à vous faire bouger !!!\n Ayant pour répertoire seulement des compositions originales, ce groupe - formé de 5 musiciens venant des quatre coins de l'Aquitaine - vous proposera un concert énergique, au cours duquel vous pourrez reconnaître leurs nombreuses influences, allant du funk à la néo-soul en passant par la pop ou la soul plus traditionnelle.\n Désormais en passe de conquérir le monde, Snawt débarque chez vous pour vous faire vivre une expérience musicale que vous n'êtes pas prêts d'oublier. Genre : Disco-Funk'n'Roll. Membres du groupe : Julien Deforges, Pauline Ducasse et Alex Castera",
  address: "Aquitaine",
  youtube_url: "https://youtu.be/us7fARCCM54",
  facebook_url: "https://www.facebook.com/snawtmusic/",
  instagram_url: "https://www.instagram.com/explore/tags/snawt/",
  soundcloud_url: "233433716"
}
p = Performance.new(demo_performance)
p.banner_url = "https://scontent.xx.fbcdn.net/v/t31.0-8/1276873_561531333882325_1696330135_o.jpg?oh=0b210f0a24f4b60f4b38a5e0b9483aa9&oe=59A2BF83"
p.avatar_url = "https://scontent.xx.fbcdn.net/v/t1.0-9/578433_368401439861983_76433700_n.jpg?oh=4446caa1ed4d5dcabd7a4baa5c2e57be&oe=59BFA53F"
p.genre = Genre.find_by_name("Disco")
p.user = User.last
p.save!
puts "done"
#Creating proposal demo
statuses = ["pending", "accepted", "refused", "confirmed"]
print "Seeding demo proposal......."
new_proposal = Proposal.new
new_proposal.event = Event.first
new_proposal.performance = Performance.find_by_name('Snawt')
new_proposal.status = statuses[0]
new_proposal.save!
puts "done"
