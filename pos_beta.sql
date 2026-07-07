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

CREATE TABLE payment_conditions(
  id SERIAL PRIMARY KEY,
  payment_condition VARCHAR(20)
);

CREATE TABLE payment_methods(
  id SERIAL PRIMARY KEY,
  payment_method VARCHAR(20)
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

----- relationt tables (rt) -----
CREATE TABLE company_platform_mode_amount(
  id SERIAL PRIMARY KEY,
  company_id INT REFERENCES companies(id),
  platform_id INT REFERENCES platforms(id),
  mode_id INT REFERENCES modes(id),
  amount_id INT REFERENCES amounts(id)
);

CREATE TABLE company_platform(
  id SERIAL PRIMARY KEY,
  company_id INT REFERENCES companies(id),
  platform_id INT REFERENCES platforms(id)
);

CREATE TABLE company_platform_amount(
  id SERIAL PRIMARY KEY,
  company_id INT REFERENCES companies(id),
  platform_id INT REFERENCES platforms(id),
  amount_id INT REFERENCES amounts(id)  
);

----- sales -----
CREATE TABLE sales(
  id SERIAL PRIMARY KEY,
  vendor_id INT REFERENCES users(id),
  client_id INT REFERENCES clients(id),
  amount DECIMAL(10,2)
);

CREATE TABLE sales_lines(
  id SERIAL PRIMARY KEY,
  sale_id INT REFERENCES sales(id),
  item_type_id VARCHAR(20),
  item_id INT,
  payment_condition_id INT REFERENCES payment_conditions(id)
);

----- credits -----
CREATE TABLE credits(
  id SERIAL PRIMARY KEY,
  client_id INT REFERENCES clients(id),
  credit DECIMAL(10, 2)
);

CREATE TABLE credit_movements(
  id SERIAL PRIMARY KEY,
  client_account_id INT REFERENCES credits(id),
  sale_line_id INT REFERENCES sales_lines(id),
  amount DECIMAL(10.2)
);

----- topup, service & pin tables -----
CREATE TABLE topups(
  id SERIAL PRIMARY KEY,
  company_platform_mode_amount_id INT REFERENCES company_platform_mode_amount(id),
  phone_number VARCHAR(15),
  folio  VARCHAR(50)
);

CREATE TABLE services(
  id SERIAL PRIMARY KEY,
  company_platform_id INT REFERENCES company_platform(id),
  amount DECIMAL(10,2),
  service_number VARCHAR(15),
  folio  VARCHAR(50)
);

CREATE TABLE pines(
  id SERIAL PRIMARY KEY,
  company_platform_amount_id INT REFERENCES company_platform_amount(id),
  phone_number VARCHAR(15),
  folio  VARCHAR(50)
);

