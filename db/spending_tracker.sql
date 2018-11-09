DROP TABLE IF EXISTS transactions
DROP TABLE IF EXISTS categories
-- DROP TABLE IF EXISTS budgets

CREATE TABLE categories (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
);

CREATE TABLE transactions (
  id SERIAL8 PRIMARY KEY,
  amount FLOAT NOT NULL,
  date_ DATE NOT NULL,
  --(YYYY-MM-DD)
  description VARCHAR(255),
  category_id INT8 REFERENCES categories(id) ON DELETE CASCADE
);

-- CREATE TABLE budgets (
--   id SERIAL8 PRIMARY KEY,

-- );
