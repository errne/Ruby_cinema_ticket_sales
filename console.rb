require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')
require('pp')

Screening.delete_all
Ticket.delete_all
Customer.delete_all
Film.delete_all



cust1 = Customer.new({'name' => 'Jessie Jones', 'funds' => 123})
cust2 = Customer.new({'name' => 'Johnny Stones', 'funds' => 75})
cust3 = Customer.new({'name' => 'Ally Vu', 'funds' => 95})
cust4 = Customer.new({'name' => 'George Bo', 'funds' => 55})
cust5 = Customer.new({'name' => 'Leela Fry', 'funds' => 45})
cust6 = Customer.new({'name' => 'Philip Fry', 'funds' => 25})

cust1.save()
cust2.save()
cust2.funds = 85
cust2.update()
cust3.save()
cust4.save()
cust5.save()
cust6.save()



film1 = Film.new({'title' => 'Up', 'price' => 10})
film2 = Film.new({'title' => 'Drown', 'price' => 20})
film3 = Film.new({'title' => 'Retrorama', 'price' => 26})

film1.save()
film2.save()
film2.title = "Down"
film2.update()
film3.save()

screen1 = Screening.new({'film_id' => film1.id, 'times' => "18:00"})
screen2 = Screening.new({'film_id' => film2.id, 'times' => "15:00"})
screen3 = Screening.new({'film_id' => film1.id, 'times' => "21:00"})
screen4 = Screening.new({'film_id' => film2.id, 'times' => "23:00"})
screen5 = Screening.new({'film_id' => film1.id, 'times' => "12:00"})
screen6 = Screening.new({'film_id' => film2.id, 'times' => "10:00"})
screen7 = Screening.new({'film_id' => film3.id, 'times' => "7:00"})

screen1.save()
screen2.save()
screen3.save()
screen4.save()
screen5.save()
screen6.save()
screen7.save()

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
cust1.buy_ticket(screen1)
cust2.buy_ticket(screen1)
cust3.buy_ticket(screen3)
cust4.buy_ticket(screen5)
cust4.buy_ticket(screen5)
cust5.buy_ticket(screen3)
cust6.buy_ticket(screen1)
cust3.buy_ticket(screen5)
cust5.buy_ticket(screen5)
cust6.buy_ticket(screen7)
# binding.pry
# nil

# p cust1.number_of_tickets_own()
# p screen1.attending_customers()
p screen5.count_attending_customers
# pp film1.all_screenings()
pp film1.most_popular_time()
# p film2.count_attending_customers()

# p cust2.booked_films()
# p film2.attending_customers()
