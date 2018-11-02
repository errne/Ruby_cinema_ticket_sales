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

  def attending_customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    values = [@id]
    customers_data = SqlRunner.run(sql, values)
    return customers_data.map{|customer| Customer.new(customer)}
  end

  def count_attending_customers()
    customers_data = attending_customers()
    return customers_data.count
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
