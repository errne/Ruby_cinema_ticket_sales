require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Ticket.delete_all
Customer.delete_all
Film.delete_all


cust1 = Customer.new({'name' => 'Jessie Jones', 'funds' => 123})
cust2 = Customer.new({'name' => 'Johnny Stones', 'funds' => 75})

cust1.save()
cust2.save()
cust2.funds = 85
cust2.update


film1 = Film.new({'title' => 'Up', 'price' => 10})
film2 = Film.new({'title' => 'Drown', 'price' => 20})

film1.save()
film2.save()
film2.title = "Down"
film2.update()

ticket1 = Ticket.new({'customer_id' => cust1.id, 'film_id' => film1.id})
ticket1.customer_id = cust2.id
ticket1.update()

ticket1.save()
