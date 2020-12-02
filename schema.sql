CREATE DATABASE skincare_app;
CREATE TABLE users (id SERIAL PRIMARY KEY, first_name TEXT, last_name TEXT, email_address TEXT, password_digest TEXT);