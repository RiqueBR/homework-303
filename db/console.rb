require('pry')
require_relative('../models/albums')
require_relative('../models/artist')

Albums.delete_all()
Artist.delete_all()

artist1 = Artist.new ({"name" => "foo fighters"})
artist1.save()

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


artist1.name = "Dave Grohl"
artist1.update()

album1.title = "Echoes, Patience, Silence and Grace"
album1.update()

artist1.albums()

binding.pry
nil
