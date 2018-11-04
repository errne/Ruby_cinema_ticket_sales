require_relative('../db/SqlRunner')
require_relative('ticket')
require_relative('film')

class Customer
  attr_accessor :name, :funds
  attr_reader :id

  def initialize ( options )
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO customers ( name, funds )
    VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def buy_ticket(screening)
    return if @funds < screening.get_film_price()
    return if screening.spaces_left == 0
    options = {'customer_id' => @id, 'screening_id' => screening.id}
    new_ticket = Ticket.new(options)
    new_ticket.save()
    decrease_funds(screening.get_film_price())
    screening.reduce_spaces_left
  end

  # def booked_films()
  #   sql = "SELECT films.* FROM films
  #   INNER JOIN tickets
  #   ON films.id = tickets.film_id
  #   WHERE customer_id = $1"
  #   values = [@id]
  #   films = SqlRunner.run(sql, values)
  #   return films.map{|film| Film.new(film)}
  # end

  def decrease_funds(ticket_price)
    @funds -= ticket_price
    self.update()
  end

  def number_of_tickets_own()
    sql = "SELECT * FROM tickets where customer_id = $1"
    values = [@id]
    tickets_data = SqlRunner.run(sql, values)
    number_of_tickets = tickets_data.map {|ticket| ticket['id']}
    return number_of_tickets.count
  end

  def self.all()
    sql = "SELECT * FROM customers"
    data = SqlRunner.run(sql)
    return data.map{|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
