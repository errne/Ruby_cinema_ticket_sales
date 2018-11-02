require_relative('../db/SqlRunner')
class Ticket
attr_accessor :customer_id, :film_id
attr_accessor :id

def initialize(options)
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
  @id = options['id'].to_i if options['id']
end

def save()
  sql = "INSERT INTO tickets (customer_id, film_id)
  VALUES ($1, $2) RETURNING id"
  values = [@customer_id, @film_id]
  ticket = SqlRunner.run(sql, values).first
  @id = ticket['id'].to_i if ticket['id']
end

def update()
  sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE * FROM tikcets where id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.all()
sql = "SELECT * FROM tickets"
data = SqlRunner.run(sql)
return data.map{|ticket| Ticket.new(ticket)}
end

def self.delete_all()
sql = "DELETE FROM tickets"
SqlRunner.run(sql)
end

end
