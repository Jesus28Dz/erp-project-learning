----- inventory -----
CREATE TABLE inventories(
  id SERIAL PRIMARY KEY,
  inventory_name VARCHAR(30),
  affiliated_branch_id INT REFERENCES branches(id)
);

----- catalogs -----
CREATE TABLE product_types(
  id SERIAL PRIMARY KEY,
  type_name VARCHAR(20)
);

CREATE TABLE product_categories(
  id SERIAL PRIMARY KEY,
  category_name VARCHAR(30)
);

----- product template
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
  product_id INT REFERENCES products(id),
  quantity_stock DECIMAL(10,2),
  purchase_cost DECIMAL(10,2),
  product_imei VARCHAR(100),
  inventory_id INT REFERENCES inventories(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

