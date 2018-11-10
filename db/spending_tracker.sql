DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS category_groups;
DROP TABLE IF EXISTS time_periods;


-- DROP TABLE IF EXISTS budgets

CREATE TABLE time_periods(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  numerator INT,
  denominator INT
);

CREATE TABLE category_groups (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  colour VARCHAR(255)
);

CREATE TABLE categories (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  category_group_id INT4 REFERENCES category_groups(id) ON DELETE CASCADE
);

CREATE TABLE transactions (
  id SERIAL8 PRIMARY KEY,
  amount FLOAT NOT NULL,
  date_ DATE,
  --(YYYY-MM-DD)
  details VARCHAR(255),
  category_id INT8 REFERENCES categories(id) ON DELETE CASCADE,
  time_period_id INT8 REFERENCES time_periods(id) ON DELETE CASCADE
);

-- CREATE TABLE budgets (
--   id SERIAL8 PRIMARY KEY,

-- );
