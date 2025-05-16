-- Drop all tables if they exist (for fresh re-creation)
DROP TABLE IF EXISTS Prescription_Medicines;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Specializations;
DROP TABLE IF EXISTS Medicines;

-- Specializations
CREATE TABLE Specializations (
  specialization_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctors
CREATE TABLE Doctors (
  doctor_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(15) NOT NULL UNIQUE,
  specialization_id INT,
  FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- Patients
CREATE TABLE Patients (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  dob DATE NOT NULL,
  gender ENUM('Male', 'Female', 'Other') NOT NULL,
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(15) NOT NULL UNIQUE
);

-- Appointments (One-to-Many: One doctor - many appointments, One patient - many appointments)
CREATE TABLE Appointments (
  appointment_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_date DATETIME NOT NULL,
  reason TEXT,
  status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Prescriptions (One-to-One with Appointments)
CREATE TABLE Prescriptions (
  prescription_id INT AUTO_INCREMENT PRIMARY KEY,
  appointment_id INT NOT NULL UNIQUE,
  notes TEXT,
  FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Medicines
CREATE TABLE Medicines (
  medicine_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT
);

-- Prescription_Medicines (Many-to-Many between Prescriptions and Medicines)
CREATE TABLE Prescription_Medicines (
  prescription_id INT,
  medicine_id INT,
  dosage VARCHAR(50),
  frequency VARCHAR(50),
  PRIMARY KEY (prescription_id, medicine_id),
  FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id),
  FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);
