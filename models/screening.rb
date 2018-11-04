require_relative('../db/SqlRunner')

class Screening
  attr_accessor :film_id, :times
  attr_reader :id

  def initialize(options)
    @film_id = options['film_id']
    @times = options['times']
    @id = options['id'] if options['id']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, times )
    VALUES ($1, $2) RETURNING id"
    values = [@film_id, @times]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i if screening['id']
  end

  def update()
    sql = "UPDATE screenings SET (film_id, times) = ($1, $2) WHERE id = $3"
    values = [@film_id, @times, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM screenings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def get_film_price()
    sql = "SELECT * FROM films
    WHERE films.id = $1" #screenings.film_id"
    values = [@film_id]
    film_data = SqlRunner.run(sql, values)
    return film_price = film_data[0]['price'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screening"
    data = SqlRunner.run(sql)
    return data.map{|screen| Screening.new(screen)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end
end
