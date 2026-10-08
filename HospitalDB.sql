CREATE DATABASE HospitalDB
USE HospitalDB
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
)

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    CONSTRAINT FK_Doctors_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
)

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20),
    Gender CHAR(1)
)

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NULL,
    DoctorID INT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason VARCHAR(100),
    CONSTRAINT FK_Appointments_Patients FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT FK_Appointments_Doctors FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
)

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES 
(1, 'Cardiology'),
(2, 'Pediatrics'),
(3, 'Neurology'),
(4, 'Radiology')

INSERT INTO Doctors (DoctorID, FirstName, LastName, Specialty, DepartmentID) VALUES 
(101, 'Kareem', 'Ahmed', 'Cardiologist', 1),
(102, 'Fady', 'Belal', 'Neurologist', 3),
(103, 'Hala', 'Alaa', 'Radiologist', 4)

INSERT INTO Patients (PatientID, FirstName, LastName, Phone, Gender) VALUES 
(1, 'Omar', 'Khaled', '01012345678', 'M'),
(2, 'Sara', 'Ibrahim', '01123456789', 'F'),
(3, 'Youssef', 'Mahmoud', '01234567890', 'M')

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason) VALUES 
(1, 101, '2026-10-10 10:00:00', 'Checkup'),
(2, 102, '2026-10-11 11:30:00', 'Vaccination'),
(3, 103, '2026-10-12 14:00:00', 'X-Ray Scan'),
(NULL, 101, '2026-10-12 09:00:00', 'Emergency Walk-in')

SELECT 
    Appointments.AppointmentID,
    Patients.FirstName AS PatientName,
    Doctors.FirstName AS DoctorName,
    Appointments.AppointmentDate
FROM Appointments
INNER JOIN Patients ON Appointments.PatientID = Patients.PatientID
INNER JOIN Doctors ON Appointments.DoctorID = Doctors.DoctorID

SELECT 
    Patients.FirstName,
    Patients.LastName,
    Appointments.AppointmentDate,
    Appointments.Reason
FROM Patients
LEFT JOIN Appointments ON Patients.PatientID = Appointments.PatientID

SELECT 
    Doctors.FirstName,
    Doctors.Specialty,
    Departments.DepartmentName
FROM Doctors
RIGHT JOIN Departments ON Doctors.DepartmentID = Departments.DepartmentID

SELECT 
    Patients.FirstName AS PatientName,
    Appointments.AppointmentDate
FROM Patients
FULL OUTER JOIN Appointments ON Patients.PatientID = Appointments.PatientID