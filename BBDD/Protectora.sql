CREATE DATABASE protectora;
CREATE USER protectoraUser identified BY 'protectora';
GRANT ALL PRIVILEGES ON protectora.* TO protectoraUser;

CREATE TABLE trabajadores (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR (100),
	telefono VARCHAR (15),
	email VARCHAR (40),
	dni VARCHAR (15)
);

CREATE TABLE animales (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR (40),
	tipo VARCHAR (20),
	edad INT,
	vacunas VARCHAR (200),
	id_trabajadores INT UNSIGNED,
	FOREIGN KEY (id_trabajadores) REFERENCES trabajadores (id)
);

INSERT INTO trabajadores (nombre, telefono, email, dni) VALUES ('Juan Manuel Jiménez', '666777888', 'juanma@gmail.com', '77889944H');
INSERT INTO trabajadores (nombre, telefono, email, dni) VALUES ('Joanna Suárez', '666555444', 'joanna@gmail.com', '77665588J');

INSERT INTO animales (nombre, tipo, edad, vacunas) VALUES ('Firulais', 'Perro', '2', 'Parvovirus, Moquillo, Adenovirus, Rabia');

SELECT *
FROM trabajadores;

SELECT *
FROM animales;