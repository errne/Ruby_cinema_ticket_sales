require_relative('../db/SqlRunner')

class Screening
  attr_accessor :film_id, :times, :capacity
  attr_reader :id, :spaces_left

  def initialize(options)
    @film_id = options['film_id']
    @times = options['times']
    @id = options['id'] if options['id']
    @capacity = 3
    @spaces_left = 3
  end

  def save()
    sql = "INSERT INTO screenings (film_id, times, spaces_left )
    VALUES ($1, $2, $3) RETURNING id"
    values = [@film_id, @times, @spaces_left]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i if screening['id']
  end

  def update()
    sql = "UPDATE screenings SET (film_id, times, spaces_left) = ($1, $2, $3) WHERE id = $4"
    values = [@film_id, @times, @spaces_left, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM screenings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def reduce_spaces_left()
    @spaces_left -= 1
    self.update()
  end

  def get_film_price()
    sql = "SELECT * FROM films
    WHERE films.id = $1" #screenings.film_id"
    values = [@film_id]
    film_data = SqlRunner.run(sql, values)
    return film_price = film_data[0]['price'].to_i
  end

  def attending_customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE screening_id = $1"
    values = [@id]
    customers_data = SqlRunner.run(sql, values)
    return customers_data.map{|customer| Customer.new(customer)}
  end

  def count_attending_customers()
    customers_data = attending_customers()
    return customers_data.count
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
