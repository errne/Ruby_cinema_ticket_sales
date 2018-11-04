require_relative('../db/SqlRunner')
class Film
  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO films (title, price )
    VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i if film['id']
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def all_screenings()
    sql = "SELECT screenings.* FROM screenings
    WHERE film_id = $1"
    values = [@id]
    screens_data = SqlRunner.run(sql, values)
    return screens_data.map{|screen| Screening.new(screen)}
  end

  def most_popular_time()
    screens_data = all_screenings()
    # screens_data.sort_by! { |screen| screen.count_attending_customers}
    # return screens_data[-1].times
    return screens_data.max_by{|screen| screen.count_attending_customers }.times
  end

  def self.all()
  sql = "SELECT * FROM films"
  data = SqlRunner.run(sql)
  return data.map{|film| Film.new(film)}
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end


end
