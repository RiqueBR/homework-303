require('pg')
require_relative('../db/sql_runner')

class Artist
  attr_accessor :id, :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map {|artist_hash| Artist.new(artist_hash)}
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ($1)
    RETURNING id"

    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update
    sql = "UPDATE artists SET
    name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end


  # def delete()
  #   sql = "DELETE FROM artists WHERE id = $1"
  #   values = [artist.id]
  #   SqlRunner.run(sql, values)
  # end


  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def albums
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map {|album_hash| Albums.new(album_hash) }
  end

end
