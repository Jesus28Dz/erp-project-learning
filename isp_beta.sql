----- isp plans -----
CREATE TABLE isp_plans(
  id SERIAL PRIMARY KEY,
  plan_name VARCHAR(30),
  plan_code VARCHAR(15),
  plan_cost DECIMAL(10,2),
  radius_group VARCHAR(30)
);

----- network_nodes -----
CREATE TABLE network_nodes(
  id SERIAL PRIMARY KEY,
  node_name VARCHAR(30),
  location_address TEXT
);

----- isp_status -----
CREATE TABLE isp_statuses(
  id SERIAL PRIMARY KEY,
  status_name VARCHAR(30)
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
