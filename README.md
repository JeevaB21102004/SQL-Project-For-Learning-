<h1 align="center">🚗 Car Sales Data Analysis using SQL</h1>

<p align="center">
  A complete SQL project where I cleaned, explored and analyzed a car sales dataset using MySQL to find business insights like top revenue brands, sales trends, discount patterns and salesperson performance.
</p>

<p align="center">
  <img alt="MySQL" src="https://img.shields.io/badge/Database-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
  <img alt="Status" src="https://img.shields.io/badge/Status-Completed-2ea44f?style=for-the-badge">
  <img alt="Level" src="https://img.shields.io/badge/Level-Beginner--Intermediate-orange?style=for-the-badge">
</p>

---

## 📌 About this project

This is a self practice SQL project I did to get better at writing real world queries — not just simple SELECTs, but data cleaning, data quality checks and actual business questions (EDA) using pure SQL.

I took a car sales dataset, loaded it into MySQL, checked it for issues, cleaned it up, and then answered 12 business questions from it.

---

## 🧰 Tools Used

| Tool | Purpose |
|------|---------|
| MySQL | Database + writing all queries |
| CSV dataset | Raw car sales data (`car_sales_data.csv`) |
| `LOAD DATA LOCAL INFILE` | Importing CSV into MySQL table |

---

## 🗂️ Dataset Overview

The dataset has one staging table `car_sales_staging` with these columns:

<details>
<summary>📋 Click to see all columns</summary>

<br>

`sale_id`, `sale_date`, `customer_name`, `customer_gender`, `customer_age`, `customer_city`, `customer_state`, `car_make`, `car_model`, `model_year`, `color`, `fuel_type`, `transmission`, `mileage_kmpl`, `base_price`, `discount`, `final_price`, `payment_method`, `branch`, `salesperson`, `warranty_years`, `customer_rating`

</details>

---

## 🧹 Step 1: Data Quality Check & Cleaning

Before jumping into analysis, I checked the data for problems. Here's what I checked:

<details>
<summary>✅ Checks I ran</summary>

- Duplicate `sale_id` values
- NULL count for every single column
- Age range validity (below 18 / above 100)
- Mileage outliers (above 50, above 60, above 100)
- Model year validity (below 1900 / future years)
- Price validity (`base_price`, `discount`, `final_price` <= 0 or mismatched)
- Category value counts for `car_make`, `car_model`, `color`, `fuel_type`, `transmission`, `payment_method`, `branch`, `salesperson`
- Rating range check (should be between 1 and 5)

</details>

This step made sure the numbers I use later in EDA are trustworthy.

---

## 📊 Step 2: Exploratory Data Analysis (EDA)

I broke the analysis into 12 business questions. Click each one to see the query + what it answers.

<details>
<summary><b>1️⃣ Overall KPIs — total sales, revenue, average sale value</b></summary>

```sql
select 
    count(*) as total_sales,
    SUM(final_price) as Revanue_amount,
    round(avg(final_price), 2) as Avgrage_amount
from car_sales_staging;
```
Gives a quick snapshot: how many cars sold, total revenue, and average price per sale.
</details>

<details>
<summary><b>2️⃣ Which car brands generate the most revenue?</b></summary>

```sql
SELECT
    car_make,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY car_make
ORDER BY total_revenue DESC;
```
Ranks every brand by total revenue — shows which brand is the top performer.
</details>

<details>
<summary><b>3️⃣ Model-wise sales analysis</b></summary>

```sql
SELECT
    car_model,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY car_model
ORDER BY total_sales DESC;
```
Finds the best-selling models by number of units sold.
</details>

<details>
<summary><b>4️⃣ State-wise sales analysis</b></summary>

```sql
SELECT
    customer_state,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY customer_state
ORDER BY total_revenue DESC;
```
Shows which states bring the most revenue — useful for regional strategy.
</details>

<details>
<summary><b>5️⃣ Sales trend over time</b></summary>

```sql
SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY sale_month;
```
Month-by-month sales trend — good for spotting seasonality/growth.
</details>

<details>
<summary><b>6️⃣ Payment method analysis</b></summary>

```sql
SELECT
    payment_method,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY payment_method
ORDER BY total_sales DESC;
```
Shows which payment method customers prefer the most.
</details>

<details>
<summary><b>7️⃣ Customer age group analysis</b></summary>

```sql
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
```
Breaks down sales by age bracket to see which age group buys the most.
</details>

<details>
<summary><b>8️⃣ Customer rating analysis</b></summary>

```sql
SELECT
    customer_rating,
    COUNT(*) AS total_sales,
    SUM(final_price) AS total_revenue
FROM car_sales_staging
GROUP BY customer_rating
ORDER BY customer_rating;
```
Checks if there's any pattern between customer satisfaction rating and sales.
</details>

<details>
<summary><b>9️⃣ Discount analysis</b></summary>

```sql
SELECT
    ROUND(MIN(discount), 2) AS min_discount,
    ROUND(MAX(discount), 2) AS max_discount,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(discount), 2) AS total_discount
FROM car_sales_staging;
```
Overall discount stats — how much discount is being given on average.
</details>

<details>
<summary><b>🔟 Discount by car brand</b></summary>

```sql
SELECT
    car_make,
    COUNT(*) AS total_sales,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND(SUM(discount), 2) AS total_discount,
    ROUND(AVG(final_price), 2) AS avg_final_price
FROM car_sales_staging
GROUP BY car_make
ORDER BY avg_discount DESC;
```
Finds which brand gets discounted the most — could point to slow-moving stock.
</details>

<details>
<summary><b>1️⃣1️⃣ Salesperson performance</b></summary>

```sql
SELECT
    salesperson,
    COUNT(*) AS total_sales,
    ROUND(SUM(final_price), 2) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY salesperson
ORDER BY total_revenue DESC;
```
Ranks salespeople by revenue generated — good for performance review.
</details>

<details>
<summary><b>1️⃣2️⃣ Branch performance</b></summary>

```sql
SELECT
    branch,
    COUNT(*) AS total_sales,
    ROUND(SUM(final_price), 2) AS total_revenue,
    ROUND(AVG(final_price), 2) AS avg_sale_value
FROM car_sales_staging
GROUP BY branch
ORDER BY total_revenue DESC;
```
Shows which branch is performing the best in terms of revenue.
</details>

---

## 🧠 What I learned from this project

- Writing data quality/cleaning queries before jumping into analysis
- Using `CASE WHEN` to create custom groups (age groups, mileage ranges)
- Aggregations with `GROUP BY`, `COUNT`, `SUM`, `AVG`, `ROUND`
- Using `DATE_FORMAT` for time-based trend analysis
- Importing a CSV into MySQL using `LOAD DATA LOCAL INFILE`

---

## 📂 Repo Structure

```
SQL-Project-For-Learning-/
├── Car Analysis.sql   # All queries — setup, cleaning, and EDA
└── README.md          # You are here
```

---

## 📬 Contact

Jeeva . B
- 📸 Instagram: [@data_with_jev](https://instagram.com/data_with_jev)
- 📧 Email: datawithjev@gmail.com

<p align="center">⭐ If you found this useful, drop a star on the repo!</p>
