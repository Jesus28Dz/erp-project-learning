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
