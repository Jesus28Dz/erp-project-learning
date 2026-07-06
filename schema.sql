----- catalog tables -----
CREATE TABLE companies(
  id SERIAL PRIMARY KEY,
  company_name VARCHAR(30)
);

CREATE TABLE platforms(
  id SERIAL PRIMARY KEY,
  platform_name VARCHAR(30)
);

CREATE TABLE modes(
  id SERIAL PRIMARY KEY,
  mode_name VARCHAR(30)
);

CREATE TABLE amounts(
  id SERIAL PRIMARY KEY,
  fixed_amount DECIMAL(10,2)
);

CREATE TABLE roles(
  id SERIAL PRIMARY KEY,
  role_name VARCHAR(20),
  privilege INT  
);

----- clients & users -----
CREATE TABLE clients(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  reference VARCHAR(15),
  address TEXT,
  phone1 VARCHAR(15),
  phone2 VARCHAR(15),
  email VARCHAR(60)
);

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  username VARCHAR(15),
  password VARCHAR(255),
  address TEXT,
  phone VARCHAR(15),
  email VARCHAR(60),
  role_id INT REFERENCES roles(id)
);

----- tables with foreign keys -----
CREATE TABLE company_platform(
  id SERIAL PRIMARY KEY,
  company_id INT REFERENCES companies(id),
  platform_id INT REFERENCES platforms(id)
);
