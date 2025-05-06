-- Create database
CREATE DATABASE clinic_appointments;

-- Use the database
USE clinic_appointments;

-- Create Departments table
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Doctors table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Create Patients table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    phone VARCHAR(15) UNIQUE
);

-- Create Specializations table
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Doctor_Specializations table (many-to-many)
CREATE TABLE Doctor_Specializations (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- Create Appointments table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Insert sample data into Departments
INSERT INTO Departments (name)
 VALUES ('Cardiology'), ('Pediatrics'), ('Dermatology');

 -- Insert sample data into Doctors
 INSERT INTO Doctors (name, email, department_id)
VALUES 
('Dr. Aisha Omar', 'aisha.omar@example.com', 1),
('Dr. Brian Kip', 'brian.kip@example.com', 2),
('Dr. Linda Njeri', 'linda.njeri@example.com', 3);

-- Insert sample data into Patients
INSERT INTO Patients (name, date_of_birth, phone)
VALUES 
('Fiona Atieno', '1998-03-15', '0712345678'),
('James Mwangi', '1985-07-02', '0713456789'),
('Lenny Kamau', '1999-01-13', '0712567890');

-- Insert sample data into Specializations
INSERT INTO Specializations (name)
 VALUES ('Cardiologist'), ('Pediatrician'), ('Dermatologist');

-- Insert sample data into Doctor_Specializations
INSERT INTO Doctor_Specializations (doctor_id, specialization_id)
VALUES 
(1, 1),
(2, 2),
(3, 3);

-- Insert sample data into Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason)
VALUES 
(1, 1, '2025-05-06 10:00:00', 'Routine cardio checkup'),
(2, 2, '2025-05-07 14:30:00', 'Croup'),
(1, 3, '2025-05-08 09:00:00', 'allergic dermatitis');


-- Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'doctor', 'receptionist') NOT NULL
);

-- Insert sample data into Users
INSERT INTO Users (username, email, password, role)
VALUES 
('admin_user', 'qwerty@gmail.com', 'hashed_password1', 'admin'),
('doctor_user', 'doctor@gmail.com', 'hashed_password2', 'doctor'),
('receptionist_user', 'reception@gmail.com', 'hashed_password3', 'receptionist');
-- Note: Passwords should be hashed in a real application. The above is just a placeholder.

