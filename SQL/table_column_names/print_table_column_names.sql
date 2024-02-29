-- Milestone 10

-- Task 2.1: Print a list of the tables in the database and save the result to a csv file for your reference--

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

--Task 2.2: Print a list of the columns in the orders table and save the result to a csv file called orders_columns.csv--

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'orders';

--Task 2.3: Repeat the same process for each other table in the database, saving the results to a csv file with the same name as the table

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'country_region';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'dim_customer';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'dim_date';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'dim_product';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'dim_store';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'forquerying2';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'forview';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'my_store_overviews';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'my_store_overviews_2';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'my_store_overviewsnew';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'new_store_overview';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'test';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'test_store_overviews';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'test_store_overviews_2';