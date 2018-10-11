-- Show all customers
SELECT * FROM Customer

-- Select Mary Hoyne's customer_id
SELECT customer_id FROM Customer WHERE customer_name = 'Mary Hoyne'

-- Select all flights
SELECT * FROM Flight

-- Select all from bookings
SELECT * FROM Booking

-- Select all from fares
SELECT * FROM Fare

-- Select all of Mary Hoyne's bookings
SELECT * FROM Booking WHERE customer_id = (SELECT customer_id FROM Customer WHERE customer_name = 'Mary Hoyne')

-- What flight_no is Mary Hoyne on on the date x
SELECT flight_no FROM Booking WHERE customer_id = (SELECT customer_id FROM Customer WHERE customer_name = 'Mary Hoyne') AND departure_date = '2013-05-21'

-- Select all flights from Dublin -> Heathrow
SELECT flight_no FROM Flight WHERE departure_airport = 'a1' AND arrival_airport = 'a3'

-- Select the fare of flight from Dublin -> Heathrow
SELECT fare FROM Fare WHERE flight_no = (SELECT flight_no FROM Flight WHERE departure_airport = 'a1' AND arrival_airport = 'a3') AND seat_class = 'b'

-- Select departure time of flight EI124
SELECT departure_time FROM Flight where flight_no = 'EI124'
