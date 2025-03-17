DROP DATABASE IF EXISTS Airline_Reservation;
-- Creating the database
CREATE DATABASE Airline_Reservation;
USE Airline_Reservation;

-- 1️⃣ Airlines Table
CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    headquarters VARCHAR(100) NOT NULL
);

-- 2️⃣ Airports Table
CREATE TABLE Airports (
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL
);

-- 3️⃣ Flights Table
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_id INT,
    departure_airport_id INT,
    arrival_airport_id INT,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    aircraft_type VARCHAR(50) NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id) ON DELETE CASCADE,
    FOREIGN KEY (departure_airport_id) REFERENCES Airports(airport_id) ON DELETE CASCADE,
    FOREIGN KEY (arrival_airport_id) REFERENCES Airports(airport_id) ON DELETE CASCADE
);

-- 4️⃣ Passengers Table
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    passport_no VARCHAR(20) UNIQUE NOT NULL,
    nationality VARCHAR(50) NOT NULL
);

-- 5️⃣ Reservations Table
CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT,
    flight_id INT,
    seat_number VARCHAR(5) NOT NULL,
    class VARCHAR(20) NOT NULL CHECK (class IN ('Economy', 'Business', 'First')),
    status VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id) ON DELETE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

-- 6️⃣ Crew Table
CREATE TABLE Crew (
    crew_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('Pilot', 'Co-Pilot', 'Attendant')),
    flight_id INT,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

-- 7️⃣ Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT NOW(),
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('Credit Card', 'PayPal', 'UPI', 'Net Banking')),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id) ON DELETE CASCADE
);

-- 8️⃣ Luggage Table
CREATE TABLE Luggage (
    luggage_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    weight_kg DECIMAL(5,2) NOT NULL,
    type VARCHAR(50) NOT NULL CHECK (type IN ('Checked-in', 'Carry-on')),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id) ON DELETE CASCADE
);

-- 9️⃣ Flight Status Table
CREATE TABLE Flight_Status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Delayed', 'Departed', 'Landed', 'Cancelled')),
    update_time DATETIME NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

-- 🔟 Offers & Discounts Table
CREATE TABLE Offers_Discounts (
    offer_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT,
    discount_percent DECIMAL(5,2) NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    expiry_date DATE NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id) ON DELETE CASCADE
);

INSERT INTO Airlines (name, country, headquarters) VALUES
('Air India', 'India', 'New Delhi'),
('Vistara', 'India', 'Gurgaon'),
('IndiGo', 'India', 'Gurgaon'),
('SpiceJet', 'India', 'Gurgaon'),
('Go First', 'India', 'Mumbai'),
('Akasa Air', 'India', 'Mumbai'),
('Alliance Air', 'India', 'Delhi'),
('AirAsia India', 'India', 'Bangalore'),
('Blue Dart Aviation', 'India', 'Chennai'),
('TruJet', 'India', 'Hyderabad'),
('Star Air', 'India', 'Bangalore'),
('Pinnacle Air', 'India', 'Delhi'),
('Taj Air', 'India', 'Mumbai'),
('Quikjet Airlines', 'India', 'Bangalore'),
('Turbo Megha Airways', 'India', 'Hyderabad'),
('Deccan Charters', 'India', 'Bangalore'),
('Pawan Hans', 'India', 'Noida'),
('Club One Air', 'India', 'Delhi'),
('IndiGo Express', 'India', 'Delhi'),
('FlyBig', 'India', 'Indore');


INSERT INTO Airports (name, city, country, code) VALUES
('Indira Gandhi International Airport', 'Delhi', 'India', 'DEL'),
('Chhatrapati Shivaji International Airport', 'Mumbai', 'India', 'BOM'),
('Kempegowda International Airport', 'Bangalore', 'India', 'BLR'),
('Chennai International Airport', 'Chennai', 'India', 'MAA'),
('Rajiv Gandhi International Airport', 'Hyderabad', 'India', 'HYD'),
('Netaji Subhash Chandra Bose Airport', 'Kolkata', 'India', 'CCU'),
('Cochin International Airport', 'Kochi', 'India', 'COK'),
('Pune International Airport', 'Pune', 'India', 'PNQ'),
('Goa International Airport', 'Goa', 'India', 'GOI'),
('Sardar Vallabhbhai Patel International Airport', 'Ahmedabad', 'India', 'AMD'),
('Jaipur International Airport', 'Jaipur', 'India', 'JAI'),
('Lokpriya Gopinath Bordoloi Airport', 'Guwahati', 'India', 'GAU'),
('Trivandrum International Airport', 'Thiruvananthapuram', 'India', 'TRV'),
('Lal Bahadur Shastri Airport', 'Varanasi', 'India', 'VNS'),
('Sri Guru Ram Dass Jee Airport', 'Amritsar', 'India', 'ATQ'),
('Biju Patnaik International Airport', 'Bhubaneswar', 'India', 'BBI'),
('Devi Ahilya Bai Holkar Airport', 'Indore', 'India', 'IDR'),
('Bagdogra Airport', 'Siliguri', 'India', 'IXB'),
('Chandigarh International Airport', 'Chandigarh', 'India', 'IXC'),
('Madurai International Airport', 'Madurai', 'India', 'IXM');

INSERT INTO Passengers (name, email, phone, passport_no, nationality) VALUES
('Amit Sharma', 'amitsharma@gmail.com', '9898765432', 'IND123456', 'Indian'),
('Priya Verma', 'priyaverma@gmail.com', '9812345678', 'IND234567', 'Indian'),
('Rohit Gupta', 'rohitgupta@gmail.com', '9876543210', 'IND345678', 'Indian'),
('Neha Singh', 'nehasingh@gmail.com', '9834567890', 'IND456789', 'Indian'),
('Vikas Joshi', 'vikasjoshi@gmail.com', '9845678901', 'IND567890', 'Indian'),
('Swati Patel', 'swatipatel@gmail.com', '9856789012', 'IND678901', 'Indian'),
('Rajesh Kumar', 'rajeshkumar@gmail.com', '9867890123', 'IND789012', 'Indian'),
('Meera Iyer', 'meera.iyer@gmail.com', '9878901234', 'IND890123', 'Indian'),
('Ankit Chauhan', 'ankitchauhan@gmail.com', '9889012345', 'IND901234', 'Indian'),
('Pooja Deshmukh', 'poojadesh@gmail.com', '9890123456', 'IND012345', 'Indian'),
('Suresh Reddy', 'sureshreddy@gmail.com', '9811123456', 'IND112345', 'Indian'),
('Kavita Nair', 'kavitanair@gmail.com', '9822234567', 'IND223456', 'Indian'),
('Vivek Malhotra', 'vivekm@gmail.com', '9833345678', 'IND334567', 'Indian'),
('Anjali Dutta', 'anjalid@gmail.com', '9844456789', 'IND445678', 'Indian'),
('Manoj Tiwari', 'manojt@gmail.com', '9855567890', 'IND556789', 'Indian'),
('Deepika Pillai', 'deepikap@gmail.com', '9866678901', 'IND667890', 'Indian'),
('Sanjay Mehta', 'sanjaym@gmail.com', '9877789012', 'IND778901', 'Indian'),
('Rekha Sharma', 'rekhasharma@gmail.com', '9888890123', 'IND889012', 'Indian'),
('Arvind Yadav', 'arvindyadav@gmail.com', '9899901234', 'IND990123', 'Indian'),
('Divya Saxena', 'divyasaxena@gmail.com', '9800012345', 'IND000123', 'Indian');



INSERT INTO Flights (airline_id, departure_airport_id, arrival_airport_id, departure_time, arrival_time, status, aircraft_type) VALUES
(1, 2, 5, '2025-02-10 10:00:00', '2025-02-10 12:30:00', 'Scheduled', 'Boeing 737'),
(2, 3, 1, '2025-02-11 08:15:00', '2025-02-11 10:45:00', 'Departed', 'Airbus A320'),
(3, 4, 6, '2025-02-12 13:30:00', '2025-02-12 16:00:00', 'Cancelled', 'Boeing 777'),
(4, 1, 7, '2025-02-13 06:45:00', '2025-02-13 09:15:00', 'Delayed', 'Airbus A380'),
(5, 5, 3, '2025-02-14 18:00:00', '2025-02-14 21:00:00', 'Scheduled', 'Embraer E190'),
(6, 8, 2, '2025-02-15 07:20:00', '2025-02-15 09:50:00', 'Departed', 'Boeing 737'),
(7, 9, 4, '2025-02-16 14:10:00', '2025-02-16 16:40:00', 'Scheduled', 'Airbus A320'),
(8, 10, 6, '2025-02-17 12:00:00', '2025-02-17 14:30:00', 'Cancelled', 'Boeing 777'),
(9, 1, 11, '2025-02-18 05:45:00', '2025-02-18 08:15:00', 'Scheduled', 'Airbus A380'),
(10, 3, 12, '2025-02-19 09:00:00', '2025-02-19 11:30:00', 'Delayed', 'Embraer E190'),
(11, 6, 1, '2025-02-20 16:30:00', '2025-02-20 19:00:00', 'Scheduled', 'Boeing 737'),
(12, 2, 14, '2025-02-21 07:45:00', '2025-02-21 10:15:00', 'Departed', 'Airbus A320'),
(13, 5, 8, '2025-02-22 20:10:00', '2025-02-22 23:40:00', 'Scheduled', 'Boeing 777'),
(14, 4, 15, '2025-02-23 11:00:00', '2025-02-23 13:30:00', 'Cancelled', 'Airbus A380'),
(15, 3, 9, '2025-02-24 14:45:00', '2025-02-24 17:15:00', 'Scheduled', 'Embraer E190'),
(16, 7, 6, '2025-02-25 10:30:00', '2025-02-25 13:00:00', 'Departed', 'Boeing 737'),
(17, 1, 18, '2025-02-26 06:15:00', '2025-02-26 08:45:00', 'Scheduled', 'Airbus A320'),
(18, 10, 5, '2025-02-27 21:00:00', '2025-02-27 23:30:00', 'Cancelled', 'Boeing 777'),
(19, 8, 17, '2025-02-28 12:30:00', '2025-02-28 15:00:00', 'Scheduled', 'Airbus A380'),
(20, 9, 11, '2025-02-28 18:45:00', '2025-02-28 21:15:00', 'Departed', 'Embraer E190');


INSERT INTO Reservations (passenger_id, flight_id, seat_number, class, status) VALUES
(1, 1, '12A', 'Economy', 'Confirmed'),
(2, 2, '5C', 'Business', 'Cancelled'),
(3, 3, '8F', 'First', 'Confirmed'),
(4, 4, '20B', 'Economy', 'Confirmed'),
(5, 5, '14D', 'Business', 'Confirmed'),
(6, 6, '6A', 'First', 'Cancelled'),
(7, 7, '9E', 'Economy', 'Confirmed'),
(8, 8, '2C', 'Business', 'Confirmed'),
(9, 9, '18F', 'First', 'Cancelled'),
(10, 10, '3B', 'Economy', 'Confirmed'),
(11, 11, '7A', 'Business', 'Confirmed'),
(12, 12, '11D', 'First', 'Cancelled'),
(13, 13, '4C', 'Economy', 'Confirmed'),
(14, 14, '10E', 'Business', 'Confirmed'),
(15, 15, '1F', 'First', 'Cancelled'),
(16, 16, '19B', 'Economy', 'Confirmed'),
(17, 17, '13A', 'Business', 'Confirmed'),
(18, 18, '5D', 'First', 'Cancelled'),
(19, 19, '8C', 'Economy', 'Confirmed'),
(20, 20, '16E', 'Business', 'Confirmed');

INSERT INTO Payments (reservation_id, amount, payment_method) VALUES
(1, 4500.50, 'UPI'),
(2, 6800.75, 'Credit Card'),
(3, 7500.00, 'Net Banking'),
(4, 6200.30, 'UPI'),
(5, 5100.00, 'Credit Card'),
(6, 8900.60, 'Net Banking'),
(7, 4200.20, 'UPI'),
(8, 9600.90, 'Credit Card'),
(9, 5700.50, 'Net Banking'),
(10, 7400.40, 'UPI'),
(11, 6900.80, 'Credit Card'),
(12, 5300.10, 'Net Banking'),
(13, 4800.00, 'UPI'),
(14, 9200.20, 'Credit Card'),
(15, 6700.30, 'Net Banking'),
(16, 6100.60, 'UPI'),
(17, 8800.90, 'Credit Card'),
(18, 4500.70, 'Net Banking'),
(19, 4900.80, 'UPI'),
(20, 9200.50, 'Credit Card');

-- If you need to update payment_date for existing records
SET SQL_SAFE_UPDATES = 0;
UPDATE Payments SET payment_date = NOW() WHERE payment_date IS NULL;
SET SQL_SAFE_UPDATES = 1; 
INSERT INTO Crew (name, role, flight_id) VALUES
('Amit Sharma', 'Pilot', 1),
('Priya Verma', 'Co-Pilot', 2),
('Rohit Gupta', 'Attendant', 3),
('Neha Singh', 'Pilot', 4),
('Vikas Joshi', 'Co-Pilot', 5),
('Swati Patel', 'Attendant', 6),
('Rajesh Kumar', 'Pilot', 7),
('Meera Iyer', 'Co-Pilot', 8),
('Ankit Chauhan', 'Attendant', 9),
('Pooja Deshmukh', 'Pilot', 10),
('Suresh Reddy', 'Co-Pilot', 11),
('Kavita Nair', 'Attendant', 12),
('Vivek Malhotra', 'Pilot', 13),
('Anjali Dutta', 'Co-Pilot', 14),
('Manoj Tiwari', 'Attendant', 15),
('Deepika Pillai', 'Pilot', 16),
('Sanjay Mehta', 'Co-Pilot', 17),
('Rekha Sharma', 'Attendant', 18),
('Arvind Yadav', 'Pilot', 19),
('Divya Saxena', 'Co-Pilot', 20);


INSERT INTO Luggage (reservation_id, weight_kg, type) VALUES
(1, 15.5, 'Checked-in'),
(2, 7.0, 'Carry-on'),
(3, 20.3, 'Checked-in'),
(4, 10.0, 'Carry-on'),
(5, 25.7, 'Checked-in'),
(6, 8.2, 'Carry-on'),
(7, 18.4, 'Checked-in'),
(8, 9.5, 'Carry-on'),
(9, 22.1, 'Checked-in'),
(10, 11.0, 'Carry-on'),
(11, 14.8, 'Checked-in'),
(12, 6.3, 'Carry-on'),
(13, 23.5, 'Checked-in'),
(14, 10.7, 'Carry-on'),
(15, 21.2, 'Checked-in'),
(16, 5.0, 'Carry-on'),
(17, 16.5, 'Checked-in'),
(18, 7.9, 'Carry-on'),
(19, 19.0, 'Checked-in'),
(20, 8.5, 'Carry-on');


-- First, drop the existing table if it exists
DROP TABLE IF EXISTS Flight_Status;

-- Recreate the Flight_Status table with the correct constraint
CREATE TABLE Flight_Status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Delayed', 'Departed', 'Landed', 'Cancelled', 'Scheduled')), -- Added 'Scheduled' to allowed values
    update_time DATETIME NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

-- Now insert the data
INSERT INTO Flight_Status (flight_id, status, update_time) VALUES
(1, 'Departed', '2025-02-10 10:30:00'),
(2, 'Delayed', '2025-02-11 08:20:00'),
(3, 'Cancelled', '2025-02-12 13:00:00'),
(4, 'Landed', '2025-02-13 09:30:00'),
(5, 'Departed', '2025-02-14 18:20:00'),
(6, 'Scheduled', '2025-02-15 07:50:00'),
(7, 'Delayed', '2025-02-16 14:30:00'),
(8, 'Cancelled', '2025-02-17 12:10:00'),
(9, 'Landed', '2025-02-18 05:50:00'),
(10, 'Departed', '2025-02-19 09:15:00'),
(11, 'Scheduled', '2025-02-20 16:45:00'),
(12, 'Delayed', '2025-02-21 07:30:00'),
(13, 'Cancelled', '2025-02-22 20:50:00'),
(14, 'Landed', '2025-02-23 11:45:00'),
(15, 'Departed', '2025-02-24 14:55:00'),
(16, 'Scheduled', '2025-02-25 10:40:00'),
(17, 'Delayed', '2025-02-26 06:25:00'),
(18, 'Cancelled', '2025-02-27 21:10:00'),
(19, 'Landed', '2025-02-28 12:45:00'),
(20, 'Departed', '2025-02-28 18:50:00');

INSERT INTO Offers_Discounts (passenger_id, discount_percent, expiry_date) VALUES
(1, 15.0, '2025-03-15'),
(2, 20.0, '2025-03-10'),
(3, 10.5, '2025-03-20'),
(4, 25.0, '2025-03-25'),
(5, 30.0, '2025-03-12'),
(6, 18.0, '2025-03-22'),
(7, 12.5, '2025-03-17'),
(8, 22.0, '2025-03-29'),
(9, 35.0, '2025-03-05'),
(10, 40.0, '2025-03-18'),
(11, 28.0, '2025-03-26'),
(12, 14.0, '2025-03-08'),
(13, 17.5, '2025-03-13'),
(14, 32.0, '2025-03-30'),
(15, 45.0, '2025-03-09'),
(16, 50.0, '2025-03-28'),
(17, 27.0, '2025-03-07'),
(18, 19.0, '2025-03-16'),
(19, 29.5, '2025-03-14'),
(20, 38.0, '2025-03-21');


select * from Airlines;
-- Get Flight Schedule with Status and Available Seats
SELECT f.flight_id, a.name AS airline, 
       dep.name AS departure_airport, arr.name AS arrival_airport, 
       f.departure_time, f.arrival_time, f.status,
       (SELECT COUNT(*) FROM Reservations r WHERE r.flight_id = f.flight_id) AS booked_seats,
       (100 - (SELECT COUNT(*) FROM Reservations r WHERE r.flight_id = f.flight_id)) AS available_seats
FROM Flights f
JOIN Airlines a ON f.airline_id = a.airline_id
JOIN Airports dep ON f.departure_airport_id = dep.airport_id
JOIN Airports arr ON f.arrival_airport_id = arr.airport_id
WHERE f.departure_time > NOW()
ORDER BY f.departure_time ASC;

-- Retrieve All Flights with Airline and Airport Details
SELECT f.flight_id, a.name AS airline, dep.name AS departure_airport, arr.name AS arrival_airport, 
       f.departure_time, f.arrival_time, f.status
FROM Flights f
JOIN Airlines a ON f.airline_id = a.airline_id
JOIN Airports dep ON f.departure_airport_id = dep.airport_id
JOIN Airports arr ON f.arrival_airport_id = arr.airport_id;


-- Count Flights Per Airline
SELECT a.name AS airline, COUNT(f.flight_id) AS total_flights
FROM Airlines a
LEFT JOIN Flights f ON a.airline_id = f.airline_id
GROUP BY a.name
ORDER BY total_flights DESC;


-- Retrieve Passengers with Reservations and Flight Details
SELECT p.name, p.email, r.seat_number, r.class, f.flight_id, f.departure_time, f.arrival_time 
FROM Reservations r
JOIN Passengers p ON r.passenger_id = p.passenger_id
JOIN Flights f ON r.flight_id = f.flight_id
ORDER BY f.departure_time DESC;


 -- Find the Most Popular Destination Airport
 SELECT arr.name AS airport, COUNT(f.flight_id) AS total_flights
FROM Flights f
JOIN Airports arr ON f.arrival_airport_id = arr.airport_id
GROUP BY arr.name
ORDER BY total_flights DESC
LIMIT 1;


-- List Crew Members for Each Flight
SELECT f.flight_id, f.departure_time, f.arrival_time, c.name AS crew_member, c.role
FROM Crew c
JOIN Flights f ON c.flight_id = f.flight_id
ORDER BY f.departure_time;


-- Find Passengers Who Have Flown More Than 5 Times
SELECT p.name, p.email, COUNT(r.reservation_id) AS flight_count
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
GROUP BY p.name, p.email
HAVING flight_count > 5;

--  the total revenue generated from each payment method.
SELECT 
    payment_method, 
    SUM(amount) AS total_revenue
FROM 
    Payments
GROUP BY 
    payment_method;
	
-- Find the most common payment method used.
SELECT 
    payment_method, 
    COUNT(*) AS count
FROM 
    Payments
GROUP BY 
    payment_method
ORDER BY 
    count DESC
LIMIT 1;

-- Find the total payment collected for each reservation made in 2025.
SELECT 
    reservation_id, 
    SUM(amount) AS total_payment
FROM 
    Payments
WHERE 
    YEAR(payment_date) = 2025
GROUP BY 
    reservation_id;
    
--  Identify duplicate payments (if any).
SELECT 
    reservation_id, 
    amount, 
    COUNT(*)
FROM 
    Payments
GROUP BY 
    reservation_id, amount
HAVING 
    COUNT(*) > 1;
    
-- Rank customers based on their total payments using window function.
DESCRIBE Reservations;
ALTER TABLE Reservations 
ADD COLUMN customer_id INT;
SELECT 
    r.customer_id,
    SUM(p.amount) AS total_payment,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS payment_rank
FROM 
    Reservations r
JOIN 
    Payments p ON r.reservation_id = p.reservation_id
GROUP BY 
    r.customer_id;

-- Find reservations where payment amount is greater than the average payment amount.
SELECT 
    reservation_id, 
    amount
FROM 
    Payments
WHERE 
    amount > (SELECT AVG(amount) FROM Payments);
    
-- Calculate cumulative payment amount for each customer over time.
SELECT 
    r.customer_id,
    p.payment_date,
    SUM(p.amount) OVER (PARTITION BY r.customer_id ORDER BY p.payment_date) AS cumulative_payment
FROM 
    Reservations r
JOIN 
    Payments p ON r.reservation_id = p.reservation_id;
    
-- Find the top 3 most expensive reservations based on total payments.
SELECT 
    reservation_id, 
    SUM(amount) AS total_payment
FROM 
    Payments
GROUP BY 
    reservation_id
ORDER BY 
    total_payment DESC
LIMIT 3;

-- Monthly Revenue Trend
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    SUM(p.amount) AS total_revenue
FROM 
    Payments p
GROUP BY 
    DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY 
    month;

--  Find Airlines with Zero Cancellations
SELECT 
    a.name AS airline_name
FROM 
    Airlines a
LEFT JOIN 
    Flights f ON a.airline_id = f.airline_id
LEFT JOIN 
    Reservations r ON f.flight_id = r.flight_id AND r.status = 'Cancelled'
WHERE 
    r.reservation_id IS NULL;
    
-- stress testing 
-- Test Transaction Rollback Under High Load
START TRANSACTION;

INSERT INTO Reservations VALUES (111, 11, 3, '2025-03-11');
INSERT INTO Payments VALUES (201, 111, 1000, '2025-03-11', 'Credit Card');

ROLLBACK;
-- Set the database to use
USE Airline_Reservation;

SHOW TABLES;

-- Stress Testing Table by Table

/* A. AIRLINES TABLE */

-- 1. Entire table displayed
SELECT * FROM Airlines;

-- 2. Check Unique Values for a Specific Airline (Sanity Check)
SELECT * FROM Airlines WHERE airline_id = 1;

-- 3. Ensure airline_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(airline_id)) AS unique_records
FROM Airlines;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Airlines WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Airline Names
SELECT name, COUNT(*) 
FROM Airlines 
GROUP BY name 
HAVING COUNT(*) > 1;

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT airline_id FROM Airlines WHERE name LIKE '%,%' OR country LIKE '%,%';

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Airlines'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Airlines'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Airlines 
MODIFY name VARCHAR(100) NOT NULL,
MODIFY country VARCHAR(50) NOT NULL;

-- 8. Check for Airlines with Missing Headquarters
SELECT * FROM Airlines WHERE headquarters IS NULL OR headquarters = '';

-- 9. Indexing for Faster Queries
CREATE INDEX idx_airline_name ON Airlines(name);
CREATE INDEX idx_airline_country ON Airlines(country);

-- ------------------------------------------------------------------------------------

/* B. AIRPORTS TABLE */

-- 1. Entire table displayed
SELECT * FROM Airports;

-- 2. Check Unique Values for a Specific Airport (Sanity Check)
SELECT * FROM Airports WHERE airport_id = 1;

-- 3. Ensure airport_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(airport_id)) AS unique_records
FROM Airports;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Airports WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Airport Codes (Should be unique)
SELECT code, COUNT(*) 
FROM Airports 
GROUP BY code 
HAVING COUNT(*) > 1;

-- 6. Check for 1st Normal Form Violations (No Multivalued Attributes)
SELECT airport_id FROM Airports WHERE name LIKE '%,%' OR city LIKE '%,%' OR country LIKE '%,%';

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Airports'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Airports'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Airports 
MODIFY name VARCHAR(100) NOT NULL,
MODIFY city VARCHAR(50) NOT NULL,
MODIFY country VARCHAR(50) NOT NULL,
MODIFY code VARCHAR(10) NOT NULL;

-- 7.2. Ensure airport code is UNIQUE
ALTER TABLE Airports
ADD CONSTRAINT uq_airport_code UNIQUE (code);

-- 8. Check for Valid Airport Codes (Usually 3 or 4 characters)
SELECT * FROM Airports WHERE LENGTH(code) NOT IN (3, 4);

-- 9. Indexing for Faster Queries
CREATE INDEX idx_airport_code ON Airports(code);
CREATE INDEX idx_airport_city ON Airports(city);
CREATE INDEX idx_airport_country ON Airports(country);

-- ------------------------------------------------------------------------------------

/* C. FLIGHTS TABLE */

-- 1. Entire table displayed
SELECT * FROM Flights;

-- 2. Check Unique Values for a Specific Flight (Sanity Check)
SELECT * FROM Flights WHERE flight_id = 1;

-- 3. Ensure flight_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(flight_id)) AS unique_records
FROM Flights;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Flights WHERE Key_name = 'PRIMARY';

-- 5. Check Foreign Key Constraints

-- 5.1. Check for flights with invalid airline_id
SELECT f.* 
FROM Flights f
LEFT JOIN Airlines a ON f.airline_id = a.airline_id
WHERE a.airline_id IS NULL;

-- 5.2. Check for flights with invalid departure_airport_id
SELECT f.* 
FROM Flights f
LEFT JOIN Airports a ON f.departure_airport_id = a.airport_id
WHERE a.airport_id IS NULL;

-- 5.3. Check for flights with invalid arrival_airport_id
SELECT f.* 
FROM Flights f
LEFT JOIN Airports a ON f.arrival_airport_id = a.airport_id
WHERE a.airport_id IS NULL;

-- 6. Check for 1st Normal Form Violations
SELECT flight_id FROM Flights WHERE status LIKE '%,%' OR aircraft_type LIKE '%,%';

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Flights'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Flights'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Flights 
MODIFY airline_id INT NOT NULL,
MODIFY departure_airport_id INT NOT NULL,
MODIFY arrival_airport_id INT NOT NULL,
MODIFY departure_time DATETIME NOT NULL,
MODIFY arrival_time DATETIME NOT NULL;

-- 7.2. Adding CHECK constraint for flight status
ALTER TABLE Flights 
ADD CONSTRAINT check_flight_status 
CHECK (status IN ('Scheduled', 'Delayed', 'Departed', 'Landed', 'Cancelled'));

-- 8. Check for Orphaned Records

-- 8.1. Check for flights with non-existent airline_id
SELECT * FROM Flights
WHERE airline_id NOT IN (SELECT airline_id FROM Airlines);

-- 8.2. Check for flights with non-existent departure_airport_id
SELECT * FROM Flights
WHERE departure_airport_id NOT IN (SELECT airport_id FROM Airports);

-- 8.3. Check for flights with non-existent arrival_airport_id
SELECT * FROM Flights
WHERE arrival_airport_id NOT IN (SELECT airport_id FROM Airports);

-- 9. Check for Invalid Flight Times

-- 9.1. Check for flights where arrival time is before departure time
SELECT * FROM Flights 
WHERE arrival_time < departure_time;

-- 9.2. Check for flights scheduled in the past
SELECT * FROM Flights 
WHERE departure_time < NOW() AND status = 'Scheduled';

-- 10. Check for Same Airport Departures and Arrivals
SELECT * FROM Flights 
WHERE departure_airport_id = arrival_airport_id;

-- 11. Indexing for Faster Queries
CREATE INDEX idx_airline_id ON Flights(airline_id);
CREATE INDEX idx_departure_airport ON Flights(departure_airport_id);
CREATE INDEX idx_arrival_airport ON Flights(arrival_airport_id);
CREATE INDEX idx_departure_time ON Flights(departure_time);
CREATE INDEX idx_status ON Flights(status);

-- ------------------------------------------------------------------------------------

/* D. PASSENGERS TABLE */

-- 1. Entire table displayed
SELECT * FROM Passengers;

-- 2. Check Unique Values for a Specific Passenger (Sanity Check)
SELECT * FROM Passengers WHERE passenger_id = 1;

-- 3. Ensure passenger_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(passenger_id)) AS unique_records
FROM Passengers;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Passengers WHERE Key_name = 'PRIMARY';

-- 5. Check for Duplicate Unique Fields

-- 5.1. Check for duplicate emails
SELECT email, COUNT(*) 
FROM Passengers 
GROUP BY email 
HAVING COUNT(*) > 1;

-- 5.2. Check for duplicate phone numbers
SELECT phone, COUNT(*) 
FROM Passengers 
GROUP BY phone 
HAVING COUNT(*) > 1;

-- 5.3. Check for duplicate passport numbers
SELECT passport_no, COUNT(*) 
FROM Passengers 
GROUP BY passport_no 
HAVING COUNT(*) > 1;

-- 6. Check for 1st Normal Form Violations
SELECT passenger_id FROM Passengers WHERE name LIKE '%,%' OR nationality LIKE '%,%';

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Passengers'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Passengers'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Passengers 
MODIFY name VARCHAR(100) NOT NULL,
MODIFY email VARCHAR(100) NOT NULL,
MODIFY phone VARCHAR(15) NOT NULL,
MODIFY passport_no VARCHAR(20) NOT NULL;

-- 7.2. Adding UNIQUE constraints
ALTER TABLE Passengers
ADD CONSTRAINT uq_passenger_email UNIQUE (email),
ADD CONSTRAINT uq_passenger_phone UNIQUE (phone),
ADD CONSTRAINT uq_passenger_passport UNIQUE (passport_no);

-- 7.3. Add constraint for valid email format
ALTER TABLE Passengers 
ADD CONSTRAINT check_email_format 
CHECK (email LIKE '%@%._%');

-- 8. Check for Invalid Phone Numbers (Basic Format Check)
SELECT * FROM Passengers 
WHERE phone NOT REGEXP '^[0-9+()-]{7,15}$';

-- 9. Indexing for Faster Queries
CREATE INDEX idx_passenger_name ON Passengers(name);
CREATE INDEX idx_passenger_nationality ON Passengers(nationality);

-- ------------------------------------------------------------------------------------

/* E. RESERVATIONS TABLE */

-- 1. Entire table displayed
SELECT * FROM Reservations;

-- 2. Check Unique Values for a Specific Reservation (Sanity Check)
SELECT * FROM Reservations WHERE reservation_id = 1;

-- 3. Ensure reservation_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(reservation_id)) AS unique_records
FROM Reservations;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Reservations WHERE Key_name = 'PRIMARY';

-- 5. Check Foreign Key Constraints

-- 5.1. Check for reservations with invalid passenger_id
SELECT r.* 
FROM Reservations r
LEFT JOIN Passengers p ON r.passenger_id = p.passenger_id
WHERE p.passenger_id IS NULL;

-- 5.2. Check for reservations with invalid flight_id
SELECT r.* 
FROM Reservations r
LEFT JOIN Flights f ON r.flight_id = f.flight_id
WHERE f.flight_id IS NULL;

-- 6. Check for Duplicate Seat Assignments (Same flight, same seat)
SELECT flight_id, seat_number, COUNT(*) 
FROM Reservations 
WHERE status = 'Confirmed'
GROUP BY flight_id, seat_number
HAVING COUNT(*) > 1;

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Reservations'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Reservations'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Reservations 
MODIFY passenger_id INT NOT NULL,
MODIFY flight_id INT NOT NULL,
MODIFY seat_number VARCHAR(5) NOT NULL,
MODIFY class VARCHAR(20) NOT NULL;

-- 7.2. Adding CHECK constraint for valid class values
ALTER TABLE Reservations 
ADD CONSTRAINT check_reservation_class 
CHECK (class IN ('Economy', 'Business', 'First'));

-- 7.3. Adding CHECK constraint for valid status values
ALTER TABLE Reservations 
ADD CONSTRAINT check_reservation_status 
CHECK (status IN ('Confirmed', 'Cancelled', 'Checked-in', 'No-show'));

-- 8. Check for Orphaned Records

-- 8.1. Check for reservations with non-existent passenger_id
SELECT * FROM Reservations
WHERE passenger_id NOT IN (SELECT passenger_id FROM Passengers);

-- 8.2. Check for reservations with non-existent flight_id
SELECT * FROM Reservations
WHERE flight_id NOT IN (SELECT flight_id FROM Flights);

-- 9. Check for Valid Seat Numbers (Format Check)
SELECT * FROM Reservations 
WHERE seat_number NOT REGEXP '^[0-9]{1,2}[A-Z]{1}$';

-- 10. Indexing for Faster Queries
CREATE INDEX idx_passenger_id ON Reservations(passenger_id);
CREATE INDEX idx_flight_id ON Reservations(flight_id);
CREATE INDEX idx_reservation_status ON Reservations(status);

-- ------------------------------------------------------------------------------------

/* F. CREW TABLE */

-- 1. Entire table displayed
SELECT * FROM Crew;

-- 2. Check Unique Values for a Specific Crew Member (Sanity Check)
SELECT * FROM Crew WHERE crew_id = 1;

-- 3. Ensure crew_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(crew_id)) AS unique_records
FROM Crew;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Crew WHERE Key_name = 'PRIMARY';

-- 5. Check Foreign Key Constraints

-- 5.1. Check for crew records with invalid flight_id
SELECT c.* 
FROM Crew c
LEFT JOIN Flights f ON c.flight_id = f.flight_id
WHERE f.flight_id IS NULL;

-- 6. Check for 1st Normal Form Violations
SELECT crew_id FROM Crew WHERE name LIKE '%,%' OR role LIKE '%,%';

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Crew'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Crew'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Crew 
MODIFY name VARCHAR(100) NOT NULL,
MODIFY role VARCHAR(50) NOT NULL,
MODIFY flight_id INT NOT NULL;

-- 7.2. Adding CHECK constraint for valid role values
ALTER TABLE Crew 
ADD CONSTRAINT check_crew_role 
CHECK (role IN ('Pilot', 'Co-Pilot', 'Attendant'));

-- 8. Check for Orphaned Records

-- 8.1. Check for crew with non-existent flight_id
SELECT * FROM Crew
WHERE flight_id NOT IN (SELECT flight_id FROM Flights);

-- 9. Check for Flight Crew Requirements (Every flight needs at least one pilot)
SELECT f.flight_id 
FROM Flights f
LEFT JOIN (
    SELECT flight_id FROM Crew WHERE role = 'Pilot'
) AS pilots ON f.flight_id = pilots.flight_id
WHERE pilots.flight_id IS NULL AND f.status != 'Cancelled';

-- 10. Indexing for Faster Queries
CREATE INDEX idx_crew_flight_id ON Crew(flight_id);
CREATE INDEX idx_crew_role ON Crew(role);

-- ------------------------------------------------------------------------------------

/* G. PAYMENTS TABLE */

-- 1. Entire table displayed
SELECT * FROM Payments;

-- 2. Check Unique Values for a Specific Payment (Sanity Check)
SELECT * FROM Payments WHERE payment_id = 1;

-- 3. Ensure payment_id is Unique (Primary Key Check)
SELECT COUNT(*);

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Payments WHERE Key_name = 'PRIMARY';

-- 5. Check Foreign Key Constraints

-- 5.1. Check for payments with invalid reservation_id
SELECT p.* 
FROM Payments p
LEFT JOIN Reservations r ON p.reservation_id = r.reservation_id
WHERE r.reservation_id IS NULL;

-- 6. Check for 1st Normal Form Violations
SELECT payment_id FROM Payments WHERE payment_method LIKE '%,%';

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Payments'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Payments'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Payments 
MODIFY reservation_id INT NOT NULL,
MODIFY amount DECIMAL(10,2) NOT NULL,
MODIFY payment_date DATETIME NOT NULL,
MODIFY payment_method VARCHAR(20) NOT NULL;

-- 7.2. Adding CHECK constraint for valid payment methods
ALTER TABLE Payments 
ADD CONSTRAINT check_payment_method 
CHECK (payment_method IN ('Credit Card', 'PayPal', 'UPI', 'Net Banking'));

-- 7.3. Adding CHECK constraint for valid amount (non-negative)
ALTER TABLE Payments 
ADD CONSTRAINT check_payment_amount 
CHECK (amount > 0);

-- 8. Check for Orphaned Records

-- 8.1. Check for payments with non-existent reservation_id
SELECT * FROM Payments
WHERE reservation_id NOT IN (SELECT reservation_id FROM Reservations);

-- 9. Check for Multiple Payments for the Same Reservation
SELECT reservation_id, COUNT(*), SUM(amount) 
FROM Payments 
GROUP BY reservation_id
HAVING COUNT(*) > 1;

-- 10. Check for Future Payment Dates
SELECT * FROM Payments 
WHERE payment_date > NOW();

-- 11. Indexing for Faster Queries
CREATE INDEX idx_payment_reservation_id ON Payments(reservation_id);
CREATE INDEX idx_payment_date ON Payments(payment_date);
CREATE INDEX idx_payment_method ON Payments(payment_method);

-- ------------------------------------------------------------------------------------

/* H. LUGGAGE TABLE */

-- 1. Entire table displayed
SELECT * FROM Luggage;

-- 2. Check Unique Values for a Specific Luggage Item (Sanity Check)
SELECT * FROM Luggage WHERE luggage_id = 1;

-- 3. Ensure luggage_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(luggage_id)) AS unique_records
FROM Luggage;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Luggage WHERE Key_name = 'PRIMARY';

-- 5. Check Foreign Key Constraints

-- 5.1. Check for luggage with invalid reservation_id
SELECT l.* 
FROM Luggage l
LEFT JOIN Reservations r ON l.reservation_id = r.reservation_id
WHERE r.reservation_id IS NULL;

-- 6. Check for 1st Normal Form Violations
SELECT luggage_id FROM Luggage WHERE type LIKE '%,%';

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Luggage'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Luggage'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Luggage 
MODIFY reservation_id INT NOT NULL,
MODIFY weight_kg DECIMAL(5,2) NOT NULL,
MODIFY type VARCHAR(50) NOT NULL;

-- 7.2. Adding CHECK constraint for valid luggage types
ALTER TABLE Luggage 
ADD CONSTRAINT check_luggage_type 
CHECK (type IN ('Checked-in', 'Carry-on'));

-- 7.3. Adding CHECK constraint for valid weight (non-negative)
ALTER TABLE Luggage 
ADD CONSTRAINT check_luggage_weight 
CHECK (weight_kg > 0);

-- 8. Check for Orphaned Records

-- 8.1. Check for luggage with non-existent reservation_id
SELECT * FROM Luggage
WHERE reservation_id NOT IN (SELECT reservation_id FROM Reservations);

-- 9. Check for Weight Limits by Luggage Type

-- 9.1. Carry-on luggage should be less than 7kg typically
SELECT * FROM Luggage 
WHERE type = 'Carry-on' AND weight_kg > 7;

-- 9.2. Checked-in luggage should be less than 32kg typically
SELECT * FROM Luggage 
WHERE type = 'Checked-in' AND weight_kg > 32;

-- 10. Check for Passengers with Excessive Luggage
SELECT l.reservation_id, COUNT(*) as luggage_count, SUM(l.weight_kg) as total_weight
FROM Luggage l
JOIN Reservations r ON l.reservation_id = r.reservation_id
GROUP BY l.reservation_id
HAVING luggage_count > 3 OR total_weight > 50;

-- 11. Indexing for Faster Queries
CREATE INDEX idx_luggage_reservation_id ON Luggage(reservation_id);
CREATE INDEX idx_luggage_type ON Luggage(type);

-- ------------------------------------------------------------------------------------

/* I. FLIGHT_STATUS TABLE */

-- 1. Entire table displayed
SELECT * FROM Flight_Status;

-- 2. Check Unique Values for a Specific Status Record (Sanity Check)
SELECT * FROM Flight_Status WHERE status_id = 1;

-- 3. Ensure status_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(status_id)) AS unique_records
FROM Flight_Status;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Flight_Status WHERE Key_name = 'PRIMARY';

-- 5. Check Foreign Key Constraints

-- 5.1. Check for status records with invalid flight_id
SELECT fs.* 
FROM Flight_Status fs
LEFT JOIN Flights f ON fs.flight_id = f.flight_id
WHERE f.flight_id IS NULL;

-- 6. Check for 1st Normal Form Violations
SELECT status_id FROM Flight_Status WHERE status LIKE '%,%';

-- 7. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Flight_Status'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Flight_Status'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Flight_Status 
MODIFY flight_id INT NOT NULL,
MODIFY status VARCHAR(20) NOT NULL,
MODIFY update_time DATETIME NOT NULL;

-- 8. Check for Orphaned Records

-- 8.1. Check for status records with non-existent flight_id
SELECT * FROM Flight_Status
WHERE flight_id NOT IN (SELECT flight_id FROM Flights);

-- 9. Check for Chronological Status Updates
SELECT fs1.status_id, fs1.flight_id, fs1.status, fs1.update_time,
       fs2.status_id, fs2.status, fs2.update_time
FROM Flight_Status fs1
JOIN Flight_Status fs2 ON fs1.flight_id = fs2.flight_id AND fs1.update_time < fs2.update_time
WHERE (fs1.status = 'Departed' AND fs2.status = 'Delayed')
   OR (fs1.status = 'Landed' AND fs2.status IN ('Delayed', 'Departed'))
   OR (fs1.status = 'Cancelled' AND fs2.status IN ('Delayed', 'Departed', 'Landed'));

-- 10. Check for Future Status Update Times
SELECT * FROM Flight_Status 
WHERE update_time > NOW();

-- 11. Indexing for Faster Queries
CREATE INDEX idx_flight_status_flight_id ON Flight_Status(flight_id);
CREATE INDEX idx_flight_status_status ON Flight_Status(status);
CREATE INDEX idx_flight_status_update_time ON Flight_Status(update_time);

-- ------------------------------------------------------------------------------------

/* J. OFFERS_DISCOUNTS TABLE */

-- 1. Entire table displayed
SELECT * FROM Offers_Discounts;

-- 2. Check Unique Values for a Specific Offer (Sanity Check)
SELECT * FROM Offers_Discounts WHERE offer_id = 1;

-- 3. Ensure offer_id is Unique (Primary Key Check)
SELECT COUNT(*) AS total_records, COUNT(DISTINCT(offer_id)) AS unique_records
FROM Offers_Discounts;

-- 4. Confirm PRIMARY KEY Constraint Exists
SHOW KEYS FROM Offers_Discounts WHERE Key_name = 'PRIMARY';

-- 5. Check Foreign Key Constraints

-- 5.1. Check for offers with invalid passenger_id
SELECT od.* 
FROM Offers_Discounts od
LEFT JOIN Passengers p ON od.passenger_id = p.passenger_id
WHERE p.passenger_id IS NULL;

-- 6. Find Columns Without Constraints (Potentially Uncontrolled Data)
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'Offers_Discounts'
AND column_name NOT IN (
    SELECT column_name FROM information_schema.key_column_usage
    WHERE table_name = 'Offers_Discounts'
);

-- 7.1. Adding NOT NULL constraints to crucial fields
ALTER TABLE Offers_Discounts 
MODIFY passenger_id INT NOT NULL,
MODIFY discount_percent DECIMAL(5,2) NOT NULL,
MODIFY expiry_date DATE NOT NULL;

-- 7.2. Adding CHECK constraint for valid discount percentage
ALTER TABLE Offers_Discounts 
ADD CONSTRAINT check_discount_percent 
CHECK (discount_percent BETWEEN 0 AND 100);

-- 8. Check for Orphaned Records

-- 8.1. Check for offers with non-existent passenger_id
SELECT * FROM Offers_Discounts
WHERE passenger_id NOT IN (SELECT passenger_id FROM Passengers);

-- 9. Check for Expired Offers
SELECT * FROM Offers_Discounts 
WHERE expiry_date < CURDATE();

-- 10. Check for Multiple Active Offers for the Same Passenger
SELECT passenger_id, COUNT(*) as offer_count
FROM Offers_Discounts
WHERE expiry_date >= CURDATE()
GROUP BY passenger_id
HAVING offer_count > 3;

-- 11. Indexing for Faster Queries
CREATE INDEX idx_offer_passenger_id ON Offers_Discounts(passenger_id);
CREATE INDEX idx_offer_expiry_date ON Offers_Discounts(expiry_date);

-- ------------------------------------------------------------------------------------

/* CROSS-TABLE CHECKS */

-- 1. Check for Consistency Between Flights and Flight_Status
SELECT f.flight_id, f.status AS flight_status, fs.status AS status_record
FROM Flights f
LEFT JOIN (
    SELECT flight_id, status
    FROM Flight_Status
    WHERE status_id IN (
        SELECT MAX(status_id)
        FROM Flight_Status
        GROUP BY flight_id
    )
) fs ON f.flight_id = fs.flight_id
WHERE f.status != COALESCE(fs.status, f.status);

-- 2. Check for Reservations Without Payments
SELECT r.reservation_id, r.passenger_id, r.flight_id
FROM Reservations r
LEFT JOIN Payments p ON r.reservation_id = p.reservation_id
WHERE p.payment_id IS NULL AND r.status = 'Confirmed';

-- 3. Check for Flights Without Crew
SELECT f.flight_id, f.departure_time
FROM Flights f
LEFT JOIN Crew c ON f.flight_id = c.flight_id
WHERE c.crew_id IS NULL AND f.status NOT IN ('Cancelled');

-- 4. Check for Overbooked Flights (Count Reservations vs Typical Capacity)
SELECT f.flight_id, f.aircraft_type, COUNT(r.reservation_id) AS reservation_count
FROM Flights f
JOIN Reservations r ON f.flight_id = r.flight_id
WHERE r.status = 'Confirmed'
GROUP BY f.flight_id, f.aircraft_type
ORDER BY reservation_count DESC
LIMIT 10;

-- 5. Check for Passengers with Multiple Reservations on the Same Flight
SELECT r.flight_id, r.passenger_id, COUNT(*) AS reservation_count
FROM Reservations r
GROUP BY r.flight_id, r.passenger_id
HAVING reservation_count > 1;

-- 6. Check for Passengers with Overlapping Flights
SELECT p.passenger_id, p.name, f1.flight_id AS flight1, f1.departure_time AS dep1, f1.arrival_time AS arr1,
       f2.flight_id AS flight2, f2.departure_time AS dep2, f2.arrival_time AS arr2
FROM Passengers p
JOIN Reservations r1 ON p.passenger_id = r1.passenger_id
JOIN Flights f1 ON r1.flight_id = f1.flight_id
JOIN Reservations r2 ON p.passenger_id = r2.passenger_id
JOIN Flights f2 ON r2.flight_id = f2.flight_id
WHERE r1.reservation_id != r2.reservation_id
  AND r1.status = 'Confirmed' AND r2.status = 'Confirmed'
  AND f1.departure_time < f2.arrival_time
  AND f2.departure_time < f1.arrival_time;

-- 7. Check for Passengers with Reservations but No Luggage
SELECT r.reservation_id, r.passenger_id, p.name, r.flight_id
FROM Reservations r
JOIN Passengers p ON r.passenger_id = p.passenger_id
LEFT JOIN Luggage l ON r.reservation_id = l.reservation_id
WHERE l.luggage_id IS NULL AND r.status = 'Confirmed';

-- 8. Check for Reservations with Discounts but No Associated Offers
SELECT r.reservation_id, r.passenger_id, p.name, py.amount
FROM Reservations r
JOIN Passengers p ON r.passenger_id = p.passenger_id
JOIN Payments py ON r.reservation_id = py.reservation_id
LEFT JOIN Offers_Discounts od ON r.passenger_id = od.passenger_id
WHERE od.offer_id IS NULL AND py.amount < (
    SELECT AVG(amount) FROM Payments
    JOIN Reservations ON Payments.reservation_id = Reservations.reservation_id
    WHERE Reservations.class = r.class
);

-- 9. Check for Passengers Who Frequently Fly on a Specific Airline
SELECT p.passenger_id, p.name, a.airline_id, a.name AS airline_name, COUNT(*) AS flight_count
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
JOIN Flights f ON r.flight_id = f.flight_id
JOIN Airlines a ON f.airline_id = a.airline_id
WHERE r.status = 'Confirmed'
GROUP BY p.passenger_id, a.airline_id
HAVING flight_count > 5
ORDER BY flight_count DESC;
