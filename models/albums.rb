require('pry')
require('pg')
require_relative('../db/sql_runner')

class Albums

  attr_accessor :title, :genre, :artist_id, :id



  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @genre = options["genre"]
    @artist_id = options["artist_id"].to_i
  end

  def save()
    sql = "INSERT INTO albums (title,genre,artist_id) VALUES ($1, $2, $3)
    RETURNING id"

    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update
    sql = "UPDATE albums SET
    (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map {|album_hash| Albums.new(album_hash)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    return Artist.new(result[0])
  end

end
