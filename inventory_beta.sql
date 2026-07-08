----- catalogs -----
CREATE TABLE product_types(
  id SERIAL PRIMARY KEY,
  type_name VARCHAR(20)
);

CREATE TABLE product_categories(
  id SERIAL PRIMARY KEY,
  category_name VARCHAR(30)
);



