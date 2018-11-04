require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Ticket.delete_all
Customer.delete_all
Film.delete_all


cust1 = Customer.new({'name' => 'Jessie Jones', 'funds' => 123})
cust2 = Customer.new({'name' => 'Johnny Stones', 'funds' => 75})
cust3 = Customer.new({'name' => 'Ally Vu', 'funds' => 25})

cust1.save()
cust2.save()
cust2.funds = 85
cust2.update()
cust3.save()


film1 = Film.new({'title' => 'Up', 'price' => 10})
film2 = Film.new({'title' => 'Drown', 'price' => 20})

film1.save()
film2.save()
film2.title = "Down"
film2.update()

screen1 = Screening.new({'film_id' => film1.id, 'times' => "18:00"})
screen2 = Screening.new({'film_id' => film2.id, 'times' => "21:00"})
screen1.save()
screen2.save()

# ticket1 = Ticket.new({'customer_id' => cust1.id, 'screening_id' => screen1.id})
# ticket2 = Ticket.new({'customer_id' => cust2.id, 'screening_id' => screen1.id})
# ticket3 = Ticket.new({'customer_id' => cust3.id, 'screening_id' => screen1.id})
# ticket1.customer_id = cust2.id
# ticket1.update()


# ticket1.save()
# cust1.update()
# ticket2.save()
# ticket3.save()
cust1.buy_ticket(screen2)
# binding.pry
# nil

# p cust1.number_of_tickets_own()
# p film2.count_attending_customers()

# p cust2.booked_films()
# p film2.attending_customers()
