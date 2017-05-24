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
print "Destroying proposals..."
Proposal.destroy_all
puts "done"
print "Destroying events..."
Event.destroy_all
puts "done"
print "Destroying performances..."
Performance.destroy_all
puts "done"
print "Destroying places..."
Place.destroy_all
puts "done"
print "Destroying users..."
User.destroy_all
puts "done"

# Adding data
# Creating 2 users for demo
print "Seeding 2 users ..."
users = [
  {
    email: 'organizer@onmuze.com',
    password: '12345678'
  },
  {
    email: 'artist@onmuze.com',
    password: '12345678'
  },
  {
    email: 'seeder@onmuze.com',
    password: '12345678'
  }
]
users.each do |user|
  new_user = User.new(user)
  new_user.save!
end
puts "done"

# Creating a bar for organizer user

print "Seeding a bar for organizer@onmuze.com"
url = "http://res.cloudinary.com/onmuze/image/upload/v1495556568/m7hytoo3mqyutjbxqpqv.jpg"
bar = {
  name: "L\'Antidote",
  address: "13bis rue Elie Gentrac",
  description: "L'Antidote vous propose : bar, repas, évènements culturels en tous genre, programmation musicale éclectique."
}
new_place = Place.new(bar)
new_place.user = User.first
new_place.save!
new_place.photo_url = url
puts ".done"

# Creating 2 events for the bar
print "Seeding events for a place"
event_photo_urls = [
  "http://res.cloudinary.com/onmuze/image/upload/c_scale,w_1920/v1495547650/background_yrtacl.jpg",
  "http://res.cloudinary.com/onmuze/image/upload/c_scale,w_1920/v1495564300/pexels-photo-169594_tebodg.jpg",
]
events = [
  {
    name: "Sun Night",
    description: "Tonight come and dance with amazing latin bands for our famous Sun night",
    scheduled_at: DateTime.parse('2017-06-03T19:00:00+02:00')
  },
  {
    name: "Electro Diving Party",
    description: "Th best french Electro Djs on the Bordeaux scene will make you rock all night long!",
    scheduled_at: DateTime.parse('2017-06-04T23:00:00+02:00')
  }
]
events.each_with_index do |event, index|
  new_event = Event.new(event)
  new_event.place = Place.first
  new_event.save!
  new_event.photo_url = event_photo_urls[index]
  print "."
end
puts "done"

# Creating genres
print "Seeding genres with event_types..."
genres = {
  "Show" => ["Standup", "Impro", "Fire shows", "Street show", "Magic show"],
  "Music" => ["World", "Jazz/Blues", "Disco/Funk", "Classical", "Pop/Rock", "HardRock/Metal", "Electro"],
  "Dance" => ["World dance", "Contemporary", "Modern Jazz", "Street Dance/Hip hop", "Classic dance"],
  "Exhibition" => ["Paintings", "Photos", "Scultptures", "Street Art", "Body Art"]
}
genres.each do |event_type, genre_array|
  genre_array.each do |genre_name|
    genre = Genre.new(name: genre_name, event_type: event_type)
    genre.save!
    print "."
  end
end
puts "done"

# Creating demo performance
print "Seeding demo performance with Snawt"
demo_performance = {
  name: "Snawt",
  description: "Let's Snawt Tonight : \nCréé en 2011, Snawt (Funk/Soul/Pop) est bien décidé à vous faire bouger !!!\n Ayant pour répertoire seulement des compositions originales, ce groupe - formé de 5 musiciens venant des quatre coins de l'Aquitaine - vous proposera un concert énergique, au cours duquel vous pourrez reconnaître leurs nombreuses influences, allant du funk à la néo-soul en passant par la pop ou la soul plus traditionnelle.\n Désormais en passe de conquérir le monde, Snawt débarque chez vous pour vous faire vivre une expérience musicale que vous n'êtes pas prêts d'oublier. Genre : Disco-Funk'n'Roll. Membres du groupe : Julien Deforges, Pauline Ducasse et Alex Castera",
  address: "Bordeaux",
  youtube_url: "https://youtu.be/us7fARCCM54",
  facebook_url: "https://www.facebook.com/snawtmusic/",
  instagram_url: "https://www.instagram.com/explore/tags/snawt/",
  soundcloud_url: "233433716"
}
p = Performance.new(demo_performance)
p.genre = Genre.find_by_name("Disco")
p.user = User.last
p.save!
p.banner_url = "http://res.cloudinary.com/onmuze/image/upload/c_scale,w_1920/v1495556570/nenst5rjmgl704nel3jw.jpg"
p.avatar_url = "http://res.cloudinary.com/onmuze/image/upload/c_scale,w_500/v1495556571/zl8hjp66qpy4xkyccqn0.jpg"
puts ".done"

#Creating proposal demo
statuses = ["pending", "accepted", "refused", "confirmed"]
print "Seeding demo proposal"
new_proposal = Proposal.new
new_proposal.event = Event.first
new_proposal.performance = Performance.find_by_name('Snawt')
new_proposal.status = statuses[0]
new_proposal.save!
puts ".done"

#Create random performances
print "Seeding Random fake performances"
descriptions = ["The best of the best !", "Come and enjoy!", "We are amazing!", "World famous artist, coming soon"]
performances = {
  "Standup" =>[
      { name: "Cloclo  Show",
        avatar: "pexels-photo-167964_ppnmnv",
        banner: "man-person-red-white_mmwkcs",
        address: "Bordeaux"
      }
    ],
  "Impro" =>[
      { name: "Twins impro",
        avatar: "man-person-clouds-apple_m6c7xe",
        banner: "pexels-photo-374384_qsyr8p",
        address: "Bordeaux"
      }
    ],
  "Fire shows" =>[
      { name: "Fire Breakers",
        avatar: "pexels-photo-237353_c4bvmk",
        banner: "pexels-photo-69894_goqyd1",
        address: "Bordeaux"
      }
    ],
  "Street show" =>[
      { name: "Cars in fury",
        avatar: "pexels-photo_gypcg2",
        banner: "pexels-photo-210061_ye0mdj",
        address: "Bordeaux"
      }
    ],
  "Magic show" =>[
      { name: "Magic Manu",
        avatar: "photo-1444703686981-a3abbc4d4fe3_o4rurr",
        banner: "pexels-photo-236243_qd27v3",
        address: "Bordeaux"
      },
      { name: "Lady Magic",
        avatar: "suit-business-man-business-man-37547_qckilg",
        banner: "pexels-photo-256546_kdwzll",
        address: "Paris"
      }
    ],
  "World" =>[
      { name: "Latino Casita",
        avatar: "pexels-photo-167964_ppnmnv",
        banner: "pexels-photo-196652_fwxdk2",
        address: "Bordeaux"
      },
      { name: "Sweeet Bossa",
        avatar: "pexels-photo-87293_as7wel",
        banner: "night-vintage-music-bokeh_w2cx6a",
        address: "Paris"
      }
    ],
  "Jazz/Blues" =>[
      { name: "Miles Dovid",
        avatar: "pexels-photo-169594_tebodg",
        banner: "pexels-photo-300333_kzcvte",
        address: "Bordeaux"
      },
      { name: "John Coldtrain",
        avatar: "pexels-photo-213709_akopss",
        banner: "pexels-photo-196652_fwxdk2",
        address: "Paris"
      }
    ],
  "Disco/Funk" =>[
      { name: "Snarky Puppies",
        avatar: "pexels-photo-196652_u57jrj",
        banner: "pexels-photo-27476_se28cy",
        address: "Bordeaux"
      },
      { name: "Famosa Groove",
        avatar: "pexels-photo-87293_as7wel",
        banner: "pexels-photo-300333_kzcvte",
        address: "Biarritz"
      }
    ],
  "Pop/Rock" =>[
      { name: "Sylvain Charleston",
        avatar: "pexels-photo_gypcg2",
        banner: "pexels-photo-196652_u57jrj",
        address: "Bordeaux"
      }
    ],
  "HardRock/Metal" =>[
      { name: "Heavy Wagon",
        avatar: "kc6h9fn0kdguaxbkowb6",
        banner: "pexels-photo-196652_u57jrj",
        address: "Biarritz"
      }
    ],
  "Electro" =>[
      { name: "DJ Greg in the Wagon",
        avatar: "invazhdyppkwlbfc3dp2",
        banner: "pexels-photo-173366_z7tus7",
        address: "Bordeaux"
      },
      { name: "DJ House",
        avatar: "suit-business-man-business-man-37547_qckilg",
        banner: "pexels-photo-332688_xes6tj",
        address: "Bordeaux"
      }
    ],
  "World dance" =>[
      { name: "Exotica Dancing Company",
        avatar: "pexels-photo-87293_as7wel",
        banner: "pexels-photo-169762_ddh3df",
        address: "Bordeaux"
      },
      { name: "Far and enough",
        avatar: "pexels-photo-237353_c4bvmk",
        banner: "pexels-photo-236171_bsvki4",
        address: "Biarritz"
      }
    ],
  "Contemporary" =>[
      { name: "Waves in movement",
        avatar: "photo-1444703686981-a3abbc4d4fe3_o4rurr",
        banner: "pexels-photo-175658_eiefoc",
        address: "Bordeaux"
      },
      { name: "South Pole",
        avatar: "pexels-photo-213709_akopss",
        banner: "pexels-photo-186263_vcqoct",
        address: "Biarritz"
      }
    ],
  "Modern Jazz" =>[
      { name: "Brooklyn Essentials",
        avatar: "pexels-photo-87293_as7wel",
        banner: "pexels-photo-12312_mftpxu",
        address: "Bordeaux"
      },
      { name: "In the Move",
        avatar: "pexels-photo-51187_exr93n",
        banner: "pexels-photo-209948_ibh2fh",
        address: "Paris"
      }
    ],
  "Street Dance/Hip hop" =>[
      { name: "Black Street Boys",
        avatar: "pexels-photo-165805_c7fmzx",
        banner: "pexels-photo-70402_jm2qm8",
        address: "Bordeaux"
      },
      { name: "Body Shakers",
        avatar: "pexels-photo-101584_j7hzve",
        banner: "pexels-photo-58091_tp2zu2",
        address: "Paris"
      }
    ],
  "Classic dance" =>[
      { name: "Russian Ballet",
        avatar: "pexels-photo-167964_ppnmnv",
        banner: "ballet-ballerina-performance-don-quixote-46158_hkvup9",
        address: "Bordeaux"
      }
    ],
  "Paintings" =>[
      { name: "Charlie Sylvano",
        avatar: "pexels-photo-107868_te2k6u",
        banner: "pexels-photo_dywwoq",
        address: "Bordeaux"
      },
      { name: "Paul Piksaro",
        avatar: "pexels-photo_gypcg2",
        banner: "pexels-photo-69903_enchlc",
        address: "Bordeaux"
      }
    ],
  "Photos" =>[
      { name: "Emy Onehouse",
        avatar: "pexels-photo-87293_as7wel",
        banner: "pexels-photo-113784_sztvz5",
        address: "Bordeaux"
      },
      { name: "Bertrand Kitty",
        avatar: "/man-person-clouds-apple_m6c7xe",
        banner: "pexels-photo-199674_scsz1l",
        address: "Paris"
      }
    ],
  "Scultptures" =>[
      { name: "Emmet Volchan",
        avatar: "pexels-photo-87293_as7wel",
        banner: "art-creative-metal-creativity_y4y2um",
        address: "Bordeaux"
      },
      { name: "Marc Chukerberg",
        avatar: "photo-1444703686981-a3abbc4d4fe3_o4rurr",
        banner: "pexels-photo-137041_nhajt5",
        address: "Paris"
      }
    ],
  "Street Art" =>[
      { name: "Larry Clinton Bomb",
        avatar: "pexels-photo-51187_exr93n",
        banner: "pexels-photo-111295_hthrjs",
        address: "Bordeaux"
      }
    ],
  "Body Art" =>[
      { name: "My sweet Body",
        avatar: "pexels-photo-87293_as7wel",
        banner: "pexels-photo-230986_fqzmpd",
        address: "Bordeaux"
      },
      { name: "Skinart Show",
        avatar: "pexels-photo-237353_c4bvmk",
        banner: "pexels-photo-194074_sxzjkw",
        address: "Bordeaux"
      }
    ],
}

seed_user = User.find_by_email("seeder@onmuze.com")

performances.each do |genre_name, performances_array|
    performances_array.each do |performance|
    data = {
      description: descriptions.sample,
      youtube_url: "https://www.youtube.com/watch?v=kk0WRHV_vt8",
      facebook_url: "https://www.facebook.com/snawtmusic/",
      instagram_url: "https://www.instagram.com/explore/tags/snawt/",
      soundcloud_url: "233433716",
      user_id: seed_user.id,
      genre_id: Genre.find_by_name(genre_name).id,
      name: performance[:name],
      address: performance[:address]
    }
    new_performance = Performance.new(data)
    new_performance.save!
    new_performance.avatar_url = "http://res.cloudinary.com/onmuze/image/upload/c_scale,w_500/v1495565034/" + performance[:avatar] + ".jpg"
    new_performance.banner_url = "http://res.cloudinary.com/onmuze/image/upload/c_scale,w_1920/v1495559831/" + performance[:banner] + ".jpg"
    print "."
  end
end
puts "done"
puts "SEED TOTALLY ACHIEVED"
