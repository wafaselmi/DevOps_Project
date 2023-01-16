CREATE USER 'auth_user'@'localhost' IDENTIFIED BY 'Aauth123';
CREATE DATABASE auth;
 GRANT ALL PRIVILIGES ON auth.* TO 'auth_user'@'localhost';
 USE auth;
 CREATE TABLE user (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY UNIQUE,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
 );

INSERT INTO user (email, password) VALUES ('wafa.selmi@insat.ucar.tn', 'admiN123');