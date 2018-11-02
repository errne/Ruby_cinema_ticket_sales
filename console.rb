require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')


cust1 = Customer.new({'name' => 'Jessie Jones', 'funds' => 123})

cust1.save()


film1 = Film.new({'title' => 'Up', 'price' => 10})

film1.save()

ticket1 = Ticket.new({'customer_id' => cust1.id, 'film_id' => film1.id})








ticket1.save()
