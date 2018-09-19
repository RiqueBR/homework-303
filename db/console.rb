require('pry')
require_relative('../models/albums')
require_relative('../models/artist')

Albums.delete_all()
Artist.delete_all()

artist1 = Artist.new ({"name" => "Foo Fighters"})
artist1.save()

artist2 = Artist.new ({"name" => "Mumford and Sons"})
artist2.save()

album1 = Albums.new ({
  "title" => "one by one",
  "genre" => "Alternative Rock",
  "artist_id" => artist1.id
  })

album1.save()

album2 = Albums.new ({
  "title" => "Greatest Hits",
  "genre" => "Alternative Rock",
  "artist_id" => artist1.id
  })

album2.save()

album3 = Albums.new ({
  "title" => "Sigh no more",
  "genre" => "Bluegrass & Folk",
  "artist_id" => artist2.id
  })

album3.save()

artist1.name = "Dave Grohl"
artist1.update()

album1.title = "Echoes, Patience, Silence and Grace"
album1.update()

artist1.albums()
album2.artist()

binding.pry
nil
