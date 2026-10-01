CREATE DATABASE HOTELS
use HOTELS



CREATE TABLE guests (
    guest_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    email NVARCHAR(100),
    address NVARCHAR(200),
    id_number NVARCHAR(50),
    nationality NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE room_types (
    type_id INT IDENTITY(1,1) PRIMARY KEY,
    type_name NVARCHAR(50) NOT NULL,
    description NVARCHAR(255),
    price_per_night DECIMAL(10,2) NOT NULL,
    max_occupancy INT
);

CREATE TABLE rooms (
    room_id INT IDENTITY(1,1) PRIMARY KEY,
    room_number NVARCHAR(10) NOT NULL UNIQUE,
    type_id INT NOT NULL,
    floor INT,
    status NVARCHAR(20) DEFAULT 'Available'
        CHECK (status IN ('Available','Occupied','Cleaning','Maintenance')),
    FOREIGN KEY (type_id) REFERENCES room_types(type_id)
);

CREATE TABLE reservations (
    reservation_id INT IDENTITY(1,1) PRIMARY KEY,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    num_guests INT DEFAULT 1,
    status NVARCHAR(20) DEFAULT 'Confirmed'
        CHECK (status IN ('Confirmed','Cancelled','Checked-in','Checked-out')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    reservation_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method NVARCHAR(30)
        CHECK (payment_method IN ('Cash','Card','Mobile Money')),
    payment_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'Paid',
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    role NVARCHAR(50) NOT NULL,
    hire_date DATE,
    salary DECIMAL(10,2)
);

CREATE TABLE services (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    service_name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE reservation_services (
    id INT IDENTITY(1,1) PRIMARY KEY,
    reservation_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT DEFAULT 1,
    service_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) DEFAULT 'staff',
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
GO


USE HotelDB;
GO

-- =========================
-- 1. ROOM_TYPES (4 rows - aasaas)
-- =========================
INSERT INTO room_types (type_name, description, price_per_night, max_occupancy) VALUES
('Single', 'One Person', 40.00, 1),
('Double', 'Two Person', 70.00, 2),
('Deluxe', 'A very well-appointed and comfortable room', 100.00, 3),
('Suite', 'Large VIP rooms with a private lounge/sitting area', 150.00, 4);
GO

-- =========================
-- 2. ROOMS (20 rows)
-- =========================
INSERT INTO rooms (room_number, type_id, floor, status) VALUES
('101', 1, 1, 'Available'),
('102', 1, 1, 'Occupied'),
('103', 2, 1, 'Available'),
('104', 2, 1, 'Cleaning'),
('105', 1, 1, 'Available'),
('201', 2, 2, 'Available'),
('202', 2, 2, 'Occupied'),
('203', 3, 2, 'Available'),
('204', 3, 2, 'Maintenance'),
('205', 1, 2, 'Available'),
('301', 3, 3, 'Available'),
('302', 3, 3, 'Occupied'),
('303', 4, 3, 'Available'),
('304', 4, 3, 'Available'),
('305', 2, 3, 'Cleaning'),
('401', 4, 4, 'Available'),
('402', 4, 4, 'Occupied'),
('403', 1, 4, 'Available'),
('404', 2, 4, 'Available'),
('405', 3, 4, 'Maintenance');
GO

-- =========================
-- 3. GUESTS (20 rows)
-- =========================
INSERT INTO guests (full_name, phone, email, address, id_number, nationality) VALUES
('Ahmed Cali', '0615551001', 'ahmed.cali@gmail.com', 'Bosaso, Somalia', 'ID1001', 'Somali'),
('Faadumo Xasan', '0615551002', 'faadumo.h@gmail.com', 'Garowe, Somalia', 'ID1002', 'Somali'),
('Maxamed Cabdi', '0615551003', 'mcabdi@gmail.com', 'Hargeisa, Somalia', 'ID1003', 'Somali'),
('Hodan Yusuf', '0615551004', 'hodan.y@gmail.com', 'Muqdisho, Somalia', 'ID1004', 'Somali'),
('Cabdirahman Nur', '0615551005', 'abdirahman.n@gmail.com', 'Bosaso, Somalia', 'ID1005', 'Somali'),
('Sahra Maxamed', '0615551006', 'sahra.m@gmail.com', 'Galkacyo, Somalia', 'ID1006', 'Somali'),
('Cali Warsame', '0615551007', 'ali.w@gmail.com', 'Bosaso, Somalia', 'ID1007', 'Somali'),
('Nasteexo Cabdi', '0615551008', 'nasteexo.a@gmail.com', 'Hargeisa, Somalia', 'ID1008', 'Somali'),
('Yusuf Ismaaciil', '0615551009', 'yusuf.i@gmail.com', 'Kismaayo, Somalia', 'ID1009', 'Somali'),
('Khadija Cumar', '0615551010', 'khadija.o@gmail.com', 'Garowe, Somalia', 'ID1010', 'Somali'),
('James Miller', '0044771234501', 'james.m@yahoo.com', 'London, UK', 'PP2001', 'British'),
('Sarah Johnson', '0044771234502', 'sarah.j@yahoo.com', 'Manchester, UK', 'PP2002', 'British'),
('Ahmed Al-Farsi', '00971501234501', 'a.farsi@hotmail.com', 'Dubai, UAE', 'PP2003', 'Emirati'),
('Fatima Al-Zahra', '00971501234502', 'fatima.z@hotmail.com', 'Abu Dhabi, UAE', 'PP2004', 'Emirati'),
('John Smith', '0016471234501', 'john.smith@gmail.com', 'Toronto, Canada', 'PP2005', 'Canadian'),
('Cabdullahi Xirsi', '0615551011', 'abdullahi.h@gmail.com', 'Bosaso, Somalia', 'ID1011', 'Somali'),
('Ifrah Cismaan', '0615551012', 'ifrah.o@gmail.com', 'Muqdisho, Somalia', 'ID1012', 'Somali'),
('Mohamed Ahmed', '00252907712345', 'mohamed.a@gmail.com', 'Bosaso, Somalia', 'ID1013', 'Somali'),
('Layla Xassan', '0615551013', 'layla.h@gmail.com', 'Hargeisa, Somalia', 'ID1014', 'Somali'),
('David Brown', '0016471234502', 'david.b@gmail.com', 'Vancouver, Canada', 'PP2006', 'Canadian');
GO

-- =========================
-- 4. EMPLOYEES (10 rows)
-- =========================
INSERT INTO employees (full_name, phone, role, hire_date, salary) VALUES
('Cabdi Salaan', '0615552001', 'Manager', '2022-01-15', 800.00),
('Hibo Cali', '0615552002', 'Receptionist', '2022-03-10', 350.00),
('Xasan Maxamed', '0615552003', 'Receptionist', '2022-05-20', 350.00),
('Amina Yusuf', '0615552004', 'Housekeeping', '2022-02-01', 250.00),
('Cabdiweli Nur', '0615552005', 'Housekeeping', '2022-04-12', 250.00),
('Sagal Cabdi', '0615552006', 'Accountant', '2022-06-01', 500.00),
('Yasin Cali', '0615552007', 'Security', '2022-01-25', 300.00),
('Deeqa Xasan', '0615552008', 'Chef', '2022-03-15', 450.00),
('Bashir Omar', '0615552009', 'Security', '2022-07-01', 300.00),
('Ruqiyo Maxamed', '0615552010', 'Housekeeping', '2022-08-10', 250.00);
GO

-- =========================
-- 5. SERVICES (6 rows)
-- =========================
INSERT INTO services (service_name, price) VALUES
('Quraac (Breakfast)', 8.00),
('Qado (Lunch)', 12.00),
('Casho (Dinner)', 15.00),
('Dhaqid Dharka (Laundry)', 5.00),
('Gaadi Aad iyo Soo Qaad (Airport Transfer)', 20.00),
('WiFi Premium', 3.00);
GO

-- =========================
-- 6. RESERVATIONS (20 rows)
-- =========================
INSERT INTO reservations (guest_id, room_id, check_in_date, check_out_date, num_guests, status) VALUES
(1, 2, '2026-09-01', '2026-09-05', 1, 'Checked-out'),
(2, 7, '2026-09-02', '2026-09-06', 2, 'Checked-out'),
(3, 12, '2026-09-03', '2026-09-08', 1, 'Checked-out'),
(4, 17, '2026-09-05', '2026-09-10', 3, 'Checked-out'),
(5, 1, '2026-09-10', '2026-09-15', 1, 'Checked-out'),
(6, 6, '2026-09-12', '2026-09-14', 2, 'Checked-out'),
(7, 11, '2026-09-15', '2026-09-20', 1, 'Checked-out'),
(8, 16, '2026-09-18', '2026-09-22', 2, 'Checked-out'),
(9, 3, '2026-09-20', '2026-09-25', 1, 'Checked-out'),
(10, 8, '2026-09-22', '2026-09-27', 2, 'Checked-out'),
(11, 13, '2026-09-25', '2026-09-29', 1, 'Checked-in'),
(12, 18, '2026-09-26', '2026-09-30', 2, 'Checked-in'),
(13, 4, '2026-09-27', '2026-10-01', 1, 'Checked-in'),
(14, 9, '2026-09-28', '2026-10-02', 3, 'Checked-in'),
(15, 14, '2026-09-29', '2026-10-03', 1, 'Confirmed'),
(16, 19, '2026-10-01', '2026-10-05', 2, 'Confirmed'),
(17, 5, '2026-10-02', '2026-10-06', 1, 'Confirmed'),
(18, 10, '2026-10-03', '2026-10-07', 2, 'Confirmed'),
(19, 15, '2026-10-05', '2026-10-09', 1, 'Confirmed'),
(20, 20, '2026-10-06', '2026-10-10', 4, 'Cancelled');
GO

-- =========================
-- 7. PAYMENTS (20 rows)
-- =========================
INSERT INTO payments (reservation_id, amount, payment_method, status) VALUES
(1, 280.00, 'Cash', 'Paid'),
(2, 280.00, 'Card', 'Paid'),
(3, 500.00, 'Mobile Money', 'Paid'),
(4, 500.00, 'Card', 'Paid'),
(5, 200.00, 'Cash', 'Paid'),
(6, 140.00, 'Mobile Money', 'Paid'),
(7, 350.00, 'Card', 'Paid'),
(8, 400.00, 'Cash', 'Paid'),
(9, 500.00, 'Mobile Money', 'Paid'),
(10, 350.00, 'Card', 'Paid'),
(11, 400.00, 'Cash', 'Paid'),
(12, 600.00, 'Card', 'Paid'),
(13, 280.00, 'Mobile Money', 'Paid'),
(14, 350.00, 'Cash', 'Paid'),
(15, 400.00, 'Card', 'Pending'),
(16, 300.00, 'Mobile Money', 'Pending'),
(17, 160.00, 'Cash', 'Pending'),
(18, 280.00, 'Card', 'Pending'),
(19, 600.00, 'Mobile Money', 'Pending'),
(20, 0.00, 'Cash', 'Cancelled');
GO

-- =========================
-- 8. RESERVATION_SERVICES (20 rows)
-- =========================
INSERT INTO reservation_services (reservation_id, service_id, quantity) VALUES
(1, 1, 4), (1, 4, 1),
(2, 2, 2), (2, 5, 1),
(3, 1, 5), (3, 3, 5),
(4, 4, 2), (4, 6, 1),
(5, 1, 5),
(6, 2, 1), (6, 3, 1),
(7, 5, 1), (7, 1, 5),
(8, 6, 1), (8, 4, 3),
(9, 3, 5),
(10, 1, 5), (10, 2, 5),
(11, 5, 1),
(12, 6, 2);
GO

-- =========================
-- 9. USERS (10 rows - la xidhiidha employees)
-- =========================
INSERT INTO users (employee_id, username, password_hash, role) VALUES
(1, 'cabdi.manager', 'HASHED_PASSWORD_1', 'admin'),
(2, 'hibo.reception', 'HASHED_PASSWORD_2', 'staff'),
(3, 'xasan.reception', 'HASHED_PASSWORD_3', 'staff'),
(4, 'amina.house', 'HASHED_PASSWORD_4', 'staff'),
(5, 'cabdiweli.house', 'HASHED_PASSWORD_5', 'staff'),
(6, 'sagal.account', 'HASHED_PASSWORD_6', 'staff'),
(7, 'yasin.security', 'HASHED_PASSWORD_7', 'staff'),
(8, 'deeqa.chef', 'HASHED_PASSWORD_8', 'staff'),
(9, 'bashir.security', 'HASHED_PASSWORD_9', 'staff'),
(10, 'ruqiyo.house', 'HASHED_PASSWORD_10', 'staff');
GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



use master
CREATE LOGIN Taller WITH PASSWORD = 'Strong@1234'

use HOTELS
CREATE USER Taller FOR LOGIN Taller

GRANT SELECT ON guests TO Taller 



-- =========================
INSERT INTO guests (full_name, phone, email, address, id_number, nationality) VALUES
('Adno Cumar Cali', '0905909447', 'adno.cumar@gmail.com', 'Bosaso, Somalia', 'ID1015', 'Somali');




















