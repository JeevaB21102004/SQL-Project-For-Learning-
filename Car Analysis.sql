-- Setup Database --

use jeevas;

select * from car_sales_staging;

select 
count(*) as total_rows
from car_sales_staging;

describe car_sales_staging;

LOAD DATA LOCAL INFILE
'C:/Users/mohan/Pictures/Acer/nagaraj/datasets/car_sales_data.csv'
INTO TABLE car_sales_staging
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Understanding Dataset --


DESCRIBE car_sales_staging;

SELECT *
FROM car_sales_staging
LIMIT 10;

SELECT COUNT(*)
FROM car_sales_staging;

-- DATA QUALITY CHECK -- 

SELECT sale_id, COUNT(*)
FROM car_sales_staging
GROUP BY sale_id
HAVING COUNT(*) > 1;


SELECT
    COUNT(*) AS total_rows,

    COUNT(*) - COUNT(sale_id) AS sale_id_null,
    COUNT(*) - COUNT(sale_date) AS sale_date_null,
    COUNT(*) - COUNT(customer_name) AS customer_name_null,
    COUNT(*) - COUNT(customer_gender) AS customer_gender_null,
    COUNT(*) - COUNT(customer_age) AS customer_age_null,
    COUNT(*) - COUNT(customer_city) AS customer_city_null,
    COUNT(*) - COUNT(customer_state) AS customer_state_null,
    COUNT(*) - COUNT(car_make) AS car_make_null,
    COUNT(*) - COUNT(car_model) AS car_model_null,
    COUNT(*) - COUNT(model_year) AS model_year_null,
    COUNT(*) - COUNT(color) AS color_null,
    COUNT(*) - COUNT(fuel_type) AS fuel_type_null,
    COUNT(*) - COUNT(transmission) AS transmission_null,
    COUNT(*) - COUNT(mileage_kmpl) AS mileage_kmpl_null,
    COUNT(*) - COUNT(base_price) AS base_price_null,
    COUNT(*) - COUNT(discount) AS discount_null,
    COUNT(*) - COUNT(final_price) AS final_price_null,
    COUNT(*) - COUNT(payment_method) AS payment_method_null,
    COUNT(*) - COUNT(branch) AS branch_null,
    COUNT(*) - COUNT(salesperson) AS salesperson_null,
    COUNT(*) - COUNT(warranty_years) AS warranty_years_null,
    COUNT(*) - COUNT(customer_rating) AS customer_rating_null

FROM car_sales_staging;


SELECT
    MIN(customer_age) AS minimum_age,
    MAX(customer_age) AS maximum_age,
    AVG(customer_age) AS average_age
FROM car_sales_staging;


SELECT
    MIN(model_year) AS minimum_year,
    MAX(model_year) AS maximum_year,
    AVG(model_year) AS average_year,
    MIN(sale_date) AS minimum_sale_date,
    MAX(sale_date) AS maximum_sale_date,
    AVG(sale_date) AS average_sale_date
FROM car_sales_staging;

SELECT
    MIN(mileage_kmpl) AS minimum_mileage,
    MAX(mileage_kmpl) AS maximum_mileage,
    AVG(mileage_kmpl) AS average_mileage
FROM car_sales_staging;


select 
	sale_id,
    car_make,
    car_model,
    mileage_kmpl
from car_sales_staging 
where mileage_kmpl > 50 
ORDER BY mileage_kmpl asc;


SELECT
    COUNT(*) AS high_mileage_count
FROM car_sales_staging
WHERE mileage_kmpl > 50;


SELECT
    car_make,
    COUNT(*) AS high_mileage_count
FROM car_sales_staging
WHERE mileage_kmpl > 50
GROUP BY car_make
ORDER BY high_mileage_count DESC;


SELECT
    car_make,
    car_model,
    COUNT(*) AS high_mileage_count,
    MIN(mileage_kmpl) AS min_mileage,
    MAX(mileage_kmpl) AS max_mileage,
    ROUND(AVG(mileage_kmpl), 2) AS avg_mileage
FROM car_sales_staging
WHERE mileage_kmpl > 100000
GROUP BY car_make, car_model
ORDER BY high_mileage_count DESC;


SELECT
    MIN(mileage_kmpl) AS min_mileage,
    MAX(mileage_kmpl) AS max_mileage,
    ROUND(AVG(mileage_kmpl), 2) AS avg_mileage
FROM car_sales_staging;


SELECT COUNT(*) AS high_mileage_count
FROM car_sales_staging
WHERE mileage_kmpl > 100000;


SELECT
    car_make,
    car_model,
    mileage_kmpl
FROM car_sales_staging
WHERE mileage_kmpl > 40
ORDER BY mileage_kmpl DESC;



SELECT
    COUNT(*) AS total_records,
    SUM(mileage_kmpl > 40) AS above_40,
    SUM(mileage_kmpl > 50) AS above_50,
    SUM(mileage_kmpl > 60) AS above_60,
    SUM(mileage_kmpl > 100) AS above_100
FROM car_sales_staging;


SELECT
    CASE
        WHEN mileage_kmpl > 100 THEN '> 100'
        WHEN mileage_kmpl > 60 THEN '61 - 100'
    END AS mileage_range,
    COUNT(*) AS record_count
FROM car_sales_staging
WHERE mileage_kmpl > 60
GROUP BY
    CASE
        WHEN mileage_kmpl > 100 THEN '> 100'
        WHEN mileage_kmpl > 60 THEN '61 - 100'
    END;

-- Data Cleaning --
    
SELECT count(*)
FROM car_sales_staging
WHERE mileage_kmpl > 60;

SELECT
    mileage_kmpl,
    COUNT(*) AS record_count
FROM car_sales_staging
WHERE mileage_kmpl > 60
GROUP BY mileage_kmpl
ORDER BY mileage_kmpl DESC;


SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT sale_id) AS unique_sale_ids
FROM car_sales_staging;


SELECT
    MIN(customer_age) AS min_age,
    MAX(customer_age) AS max_age,
    SUM(customer_age < 18) AS below_18,
    SUM(customer_age > 100) AS above_100
FROM car_sales_staging;

SELECT
    customer_gender,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY customer_gender
ORDER BY record_count DESC;


SELECT
    car_make,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY car_make
ORDER BY record_count DESC;


SELECT
    car_model,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY car_model
ORDER BY record_count DESC;


SELECT
    car_make,
    car_model,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY car_make, car_model
ORDER BY car_make, car_model;


SELECT
    MIN(selling_price) AS min_price,
    MAX(selling_price) AS max_price,
    SUM(selling_price <= 0) AS invalid_price_count
FROM car_sales_staging;

SELECT
    MIN(model_year) AS min_year,
    MAX(model_year) AS max_year,
    SUM(model_year < 1900) AS below_1900,
    SUM(model_year > YEAR(CURDATE())) AS future_year
FROM car_sales_staging;

select
	color,
    count(*) as Total
from car_sales_staging
group by color
order by Total desc;


SELECT
    fuel_type,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY fuel_type
ORDER BY record_count DESC;


SELECT
    transmission,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY transmission
ORDER BY record_count DESC;


SELECT
    MIN(base_price) AS min_price,
    MAX(base_price) AS max_price,
    ROUND(AVG(base_price), 2) AS avg_price,
    SUM(base_price <= 0) AS invalid_price
FROM car_sales_staging;


SELECT
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount,
    ROUND(AVG(discount), 2) AS avg_discount,
    SUM(discount < 0) AS negative_discount
FROM car_sales_staging;

SELECT
    COUNT(*) AS invalid_discount_records
FROM car_sales_staging
WHERE discount > base_price;


SELECT
    COUNT(*) AS total_records,
    SUM(final_price <= 0) AS invalid_final_price,
    SUM(final_price <> base_price - discount) AS price_mismatch
FROM car_sales_staging;

SELECT
    payment_method,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY payment_method
ORDER BY record_count DESC;

SELECT
    branch,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY branch
ORDER BY record_count DESC;

SELECT
    salesperson,
    COUNT(*) AS record_count
FROM car_sales_staging
GROUP BY salesperson
ORDER BY record_count DESC;


SELECT
    MIN(warranty_years) AS min_warranty,
    MAX(warranty_years) AS max_warranty,
    ROUND(AVG(warranty_years), 2) AS avg_warranty,
    SUM(warranty_years < 0) AS negative_warranty
FROM car_sales_staging;



SELECT
    MIN(customer_rating) AS min_rating,
    MAX(customer_rating) AS max_rating,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    SUM(customer_rating < 1) AS below_1,
    SUM(customer_rating > 5) AS above_5
FROM car_sales_staging;



-- Data Analysis Process --

-- EDA 1: KPI --

select 
	count(*) as total_sales,
    SUM(final_price) as Revanue_amount,
    round(avg(final_price), 2) as Avgrage_amount
from car_sales_staging;

-- EDA 2: Which car brands generate the most revenue?  --

SELECT
    car_make,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY car_make
ORDER BY total_revenue DESC;

-- EDA 3 – Model-wise Sales Analysis complete. --

SELECT
    car_model,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY car_model
ORDER BY total_sales DESC;

-- EDA 4 — State-wise Sales Analysis --

SELECT
    customer_state,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY customer_state
ORDER BY total_revenue DESC;

-- EDA 5 — Sales Trend Over Time --

SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sale_month;

-- EDA 6 – Payment Method Analysis complete. --

SELECT
    payment_method,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY payment_method
ORDER BY total_sales DESC;

-- EDA 7 – Customer Age Group Analysis complete. --

SELECT
    CASE
        WHEN customer_age BETWEEN 21 AND 30 THEN '21-30'
        WHEN customer_age BETWEEN 31 AND 40 THEN '31-40'
        WHEN customer_age BETWEEN 41 AND 50 THEN '41-50'
        WHEN customer_age BETWEEN 51 AND 60 THEN '51-60'
        WHEN customer_age BETWEEN 61 AND 65 THEN '61-65'
    END AS age_group,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY age_group
ORDER BY age_group;

-- EDA 8 – Customer Rating Analysis complete. --

SELECT
    customer_rating,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue
FROM car_sales_staging
GROUP BY customer_rating
ORDER BY customer_rating;

-- EDA 9 — Discount Analysis --
SELECT
    ROUND(MIN(discount), 2) AS min_discount,
    ROUND(MAX(discount), 2) AS max_discount,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(discount), 2) AS total_discount
FROM car_sales_staging;

-- EDA 10 — Discount by Car Brand --

SELECT
    car_make,
    COUNT(*) AS total_sales,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(discount), 2) AS total_discount,
    ROUND(AVG(final_price), 2) AS avg_final_price
FROM car_sales_staging
GROUP BY car_make
ORDER BY avg_discount DESC;

-- EDA 11 — Salesperson Performance --

SELECT
    salesperson,
    COUNT(*) AS total_sales,
    ROUND(SUM(final_price), 2) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY salesperson
ORDER BY total_revenue DESC;

-- EDA 12 – Branch Performance --

SELECT
    branch,
    COUNT(*) AS total_sales,
    ROUND(SUM(final_price), 2) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY branch
ORDER BY total_revenue DESC;


