# 🏨 Hotel Management SQL Database System

A robust, multi-user SQL Server database solution designed to streamline hotel operations, manage bookings, automate billing, and ensure data security with advanced role-based access control and analytics.

---

## 🌟 Key Features

* **Multi-User Architecture:** Supports simultaneous connections for Receptionists, Cashiers, and Managers.
* **Role-Based Security (Permissions):** Implements strict schema permissions and custom roles (e.g., `db_datareader`, restricted write access) to protect sensitive financial data.
* **Double-Booking Prevention:** Relational integrity constraints ensuring room availability conflict resolution.
* **Automated Data Protection:** Configured with online SQL Server Agent jobs for automated daily backups without system downtime.
* **Power BI Analytics Ready:** Optimized schema views for seamless integration with Power BI business intelligence dashboards.

---

## 📐 Entity Relationship Diagram (ERD)

Below is the database schema structure showing the relationships between Rooms, Guests, Reservations, Payments, and Staff:

![Hotel Database Schema](schema-diagram.png)

---

## 🗄️ Database Schema & Structure

The system consists of the following core entities:
* `Guests` - Stores customer profiles and identification details.
* `Rooms` - Tracks room numbers, types, pricing, and occupancy status.
* `Reservations` - Manages check-in/check-out dates, room assignments, and booking statuses.
* `Payments / Transactions` - Logs cashier entries, payment methods, and timestamps.
* `Users / Roles` - Handles application users and SQL Server logins.

---

## 🚀 Getting Started & Setup

### Prerequisites
* Microsoft SQL Server 2019 or later
* SQL Server Management Studio (SSMS)

### Installation
1. Clone this repository:
   ```bash
   git clone [https://github.com/YOUR-USERNAME/Hotel-Management-SQL-Database.git](https://github.com/YOUR-USERNAME/Hotel-Management-SQL-Database.git)


   Open SSMS and execute the initialization script:

SQL
-- Run Schema.sql to construct tables, relationships, and constraints
Execute sample seed data script to populate initial test environment.

🛠️ Tech Stack & Tools
Database Engine: Microsoft SQL Server

Management Tool: SQL Server Management Studio (SSMS)

Modeling Tool: dbdiagram.io

Analytics Integration: Microsoft Power BI

👨‍💻 Developed By
Eng. Amiin Abdullahi Yuusuf

SQL Database & IT Infrastructure Specialist

📍 Bosaso, Puntland, Somalia

📧 Email: amiinabdalla909@gmail.com

📞 Phone: +252 904661683
