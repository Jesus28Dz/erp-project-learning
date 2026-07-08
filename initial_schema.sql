----- catalog tables -----
CREATE TABLE companies(
  id SERIAL PRIMARY KEY,
  company_name VARCHAR(30),
  company_code VARCHAR(10)
);

CREATE TABLE platforms(
  id SERIAL PRIMARY KEY,
  platform_name VARCHAR(30)
);

CREATE TABLE modalities(
  id SERIAL PRIMARY KEY,
  modality_name VARCHAR(30)
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

CREATE TABLE credit_movement_types(
  id SERIAL PRIMARY KEY,
  movement_type VARCHAR(20)
);

CREATE TABLE credit_states(
  id SERIAL PRIMARY KEY,
  credit_state VARCHAR(20)
);

CREATE TABLE branches(
  id SERIAL PRIMARY KEY,
  branch_name VARCHAR(30),
  branch_code VARCHAR(10)
);

CREATE TABLE equipment_types(
  id SERIAL PRIMARY KEY,
  equipment_type VARCHAR(30)
);

CREATE TABLE equipment_brands(
  id SERIAL PRIMARY KEY,
  equipment_brand VARCHAR(30)
);

CREATE TABLE equipment_models(
  id SERIAL PRIMARY KEY,
  equipment_model VARCHAR(30)
);

CREATE TABLE general_failures(
  id SERIAL PRIMARY KEY,
  general_failure VARCHAR(30)
);

CREATE TABLE repair_status(
  id SERIAL PRIMARY KEY,
  status VARCHAR(30)
);

CREATE TABLE isp_plans(
  id SERIAL PRIMARY KEY,
  plan_name VARCHAR(30),
  plan_code VARCHAR(15),
  plan_cost DECIMAL(10,2),
  radius_group VARCHAR(30)
);

CREATE TABLE network_nodes(
  id SERIAL PRIMARY KEY,
  node_name VARCHAR(30),
  location_address TEXT
);

CREATE TABLE isp_statuses(
  id SERIAL PRIMARY KEY,
  status_name VARCHAR(30)
);

CREATE TABLE product_types(
  id SERIAL PRIMARY KEY,
  type_name VARCHAR(20)
);

CREATE TABLE product_categories(
  id SERIAL PRIMARY KEY,
  category_name VARCHAR(30)
);

----- clients & users -----
CREATE TABLE clients(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  reference VARCHAR(15),
  address TEXT,
  phone1 VARCHAR(15),
  phone2 VARCHAR(15),
  email VARCHAR(60),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  username VARCHAR(15),
  password VARCHAR(255),
  address TEXT,
  phone VARCHAR(15),
  email VARCHAR(60),
  role_id INT REFERENCES roles(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----- relation tables (rt) -----
CREATE TABLE company_platform_mode_amount(
  id SERIAL PRIMARY KEY,
  company_id INT REFERENCES companies(id),
  platform_id INT REFERENCES platforms(id),
  modality_id INT REFERENCES modalities(id),
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
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales_lines(
  id SERIAL PRIMARY KEY,
  sale_id INT REFERENCES sales(id),
  item_type VARCHAR(20),
  item_id INT,
  payment_condition_id INT REFERENCES payment_conditions(id),
  amount DECIMAL(10,2)
);

CREATE TABLE sales_payments(
  id SERIAL PRIMARY KEY,
  sale_id INT REFERENCES sales(id),
  payment_method_id INT REFERENCES payment_methods(id),
  amount DECIMAL(10,2)
);

----- index -----
CREATE INDEX idx_sales_lines_item_type ON sales_lines(item_type, item_id);
CREATE INDEX idx_sales_lines_sale_id ON sales_lines(sale_id);

----- credits -----
CREATE TABLE credits(
  id SERIAL PRIMARY KEY,
  client_id INT REFERENCES clients(id),
  credit DECIMAL(10,2)
);

CREATE TABLE credit_movements(
  id SERIAL PRIMARY KEY,
  client_account_id INT REFERENCES credits(id),
  sale_line_id INT REFERENCES sales_lines(id),
  movement_type_id INT REFERENCES credit_movement_types(id),
  movement_state_id INT REFERENCES credit_states(id),
  amount DECIMAL(10,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----- topup, service & pin tables -----
CREATE TABLE topups(
  id SERIAL PRIMARY KEY,
  company_platform_mode_amount_id INT REFERENCES company_platform_mode_amount(id),
  phone_number VARCHAR(15),
  folio  VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE services(
  id SERIAL PRIMARY KEY,
  company_platform_id INT REFERENCES company_platform(id),
  amount DECIMAL(10,2),
  service_number VARCHAR(15),
  folio  VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pins(
  id SERIAL PRIMARY KEY,
  company_platform_amount_id INT REFERENCES company_platform_amount(id),
  phone_number VARCHAR(15),
  folio  VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----- repairs -----
CREATE TABLE repairs(
  id SERIAL PRIMARY KEY,
  receiving_branch_id INT REFERENCES branches(id),
  folio VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  receiving_user_id INT REFERENCES users(id),
  client_name VARCHAR(50),
  equipment_type_id INT REFERENCES equipment_types(id),
  equipment_brand_id INT REFERENCES equipment_brands(id),
  equipment_model_id INT REFERENCES equipment_models(id),
  diagnosis VARCHAR(255),
  general_failure_id INT REFERENCES general_failures(id),
  observations TEXT,
  phone VARCHAR(15),
  status_id INT REFERENCES repair_status(id)
);

----- inventory -----
CREATE TABLE inventories(
  id SERIAL PRIMARY KEY,
  inventory_name VARCHAR(30),
  affiliated_branch_id INT REFERENCES branches(id)
);

----- products -----
CREATE TABLE products(
  id SERIAL PRIMARY KEY,
  product_name VARCHAR(120),
  product_code VARCHAR(30),
  sale_price DECIMAL(10,2),
  tax_percentage DECIMAL(5,2) DEFAULT 0.00, 
  product_type_id INT REFERENCES product_types(id),
  product_category_id INT REFERENCES product_categories(id),
  product_barcode VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_inventories(
  id SERIAL PRIMARY KEY,
  inventory_id INT REFERENCES inventories(id),
  product_id INT REFERENCES products(id),
  quantity_stock DECIMAL(10,2),
  purchase_cost DECIMAL(10,2),
  product_imei VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

----- routers -----
CREATE TABLE isp_routers(
  id SERIAL PRIMARY KEY,
  router_name VARCHAR(30),
  ipv4_address VARCHAR(30),
  ipv6_address VARCHAR(39),
  api_user VARCHAR(20),
  api_password VARCHAR(50),
  network_node_id INT REFERENCES network_nodes(id)
);

----- contracts -----
CREATE TABLE isp_contracts(
  id SERIAL PRIMARY KEY,
  affiliated_client INT REFERENCES clients(id),
  plan_id INT REFERENCES isp_plans(id),
  status_id INT REFERENCES isp_statuses(id),
  product_inventory_id INT REFERENCES product_inventories(id),
  isp_router_id INT REFERENCES isp_routers(id),
  ipv4_address VARCHAR(30),
  ipv6_address VARCHAR(39),
  radius_user VARCHAR(20),
  radius_password VARCHAR(20),
  payday INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
