# Protectora

*Animal shelter management web application* built with Java, JSP, and MariaDB.

> Prácticas Presenciales Mayo 2026 — 1º DAM/DAW — Centro San Valero, Zaragoza

---

## Project Overview

Protectora is a full-stack web application for managing an animal shelter.
It allows staff to register and manage animals and their caretakers and assign animals to employees.

The application is built using Java Servlets as controllers, JSP pages as views, and JDBI as the database access layer over a MariaDB database.

---

## Implemented Features

### Required (obligatory)

Database -> Entity-Relationship model designed; SQL script creates trabajadores and animales tables with FK constraint
List & Detail -> Animals listed as Bootstrap cards on index.jsp; full detail view on view-animals.jsp and view-employees.jsp
Register & Delete -> CRUD forms for both entities; safe delete with referential integrity check for employees
English UI -> All interface text, labels, buttons and messages are in English
Git Flow -> GitHub repository with README, feature branches, Pull Requests, 4+ intermediate tags, and Release v1.0

### Optional (additional points)

Modify -> Edit Animal and Edit Employee forms support both create and update actions
Search / Filter -> Filter animals by type on the home page; search employees by name
Relationships -> Animals are assigned to a caretaker (FK); animal detail shows the caretaker's name
JavaScript (AJAX) -> Both edit forms use $.ajax to submit data asynchronously without page reload
Bootstrap -> Full Bootstrap 5 layout: responsive grid, cards, tables, alerts, badges
Responsive Design through Bootstrap -> row-cols-sm-2 row-cols-md-3 adapts listings to mobile, tablet, and desktop

---

## Database

Database name: protectora  
User: protectoraUser  
Password: protectora

### Entity-Relationship Model

trabajadores (1) ──────── (N) animales

### Schema

sql
CREATE TABLE trabajadores (
id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre    VARCHAR(100),
telefono  VARCHAR(15),
email     VARCHAR(40),
dni       VARCHAR(15)
);

CREATE TABLE animales (
id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre          VARCHAR(40),
tipo            VARCHAR(20),
edad            INT,
vacunas         VARCHAR(200),
id_trabajadores INT UNSIGNED,
FOREIGN KEY (id_trabajadores) REFERENCES trabajadores(id)
);

---

## Getting Started

### Prerequisites

- Java 17 or higher
- Apache Tomcat 10+
- MariaDB or MySQL server
- Maven 3.6+

### 1. Clone or Download the repository

Clone or Download the repository from https://github.com/Practicas-Presenciales/Protectora

### 2. Set up the database

Connect to your MariaDB/MySQL server and run the SQL script:

This will:
- Create the protectora database
- Create the protectoraUser user with the required grants
- Create both tables with the FK constraint
- Insert two sample employees and one sample animal

### 3. Deploy to Tomcat

Open the IntelliJ IDE application and open the downloaded project from the repository, then, 
having Tomcat startup in CMD and using the commands in pom.xml you can deploy it.

### 4. Open the application

http://localhost:8080/protectora/

---

## Key Pages

Home -> /index.jsp -> Animal listing with type filter 
Animal Detail -> /view-animals.jsp?id={id} -> Full animal info + caretaker
Add -> Edit Animal -> /edit-animals.jsp or /edit-animals.jsp?id={id} -> AJAX form
Employee List -> /employees-list.jsp -> Employee table with name search
Employee Detail -> /view-employees.jsp?id={id} -> Full employee info
Add -> Edit Employee -> /edit-employees.jsp or /edit-employees.jsp?id={id} -> AJAX form

---

## Business Rules

- An employee *cannot be deleted* if they have animals assigned. The application checks this before deletion and shows an error message.
- Animal forms require a valid name and a caretaker selection.
- All AJAX responses return Bootstrap-styled alert-success or alert-danger HTML fragments.

---

## Git Flow

This project follows Git Flow conventions:

- main — stable, production-ready code
- develop — integration branch
- feature/* — one branch per feature or fix, merged via Pull Request
- Tags: v0.1, v0.2, v0.3, v1.0 marking key milestones
- *Release*: v1.0 published as a GitHub Release

---

## Authors

Developed as a group project for the *Prácticas Presenciales Mayo 2026*
— 1º Desarrollo de Aplicaciones Multiplataforma
— *Centro San Valero*, Zaragoza
