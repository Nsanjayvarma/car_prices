create database car_sales;
CREATE TABLE  car_prices (
    year INT,
    make VARCHAR(100),
    model VARCHAR(50),
    trim VARCHAR(100),
    body VARCHAR(30),
    transmission VARCHAR(19),
    vin VARCHAR(49) PRIMARY KEY,
    state CHAR(2),
    `condition` int,
    odometer FLOAT,
    color VARCHAR(30),
    interior VARCHAR(19),
    seller VARCHAR(29),
    mmr VARCHAR(100),
    sellingprice FLOAT,
    saledate DATE TIME);
select * from car_prices;


--- how the count the table -----
select count(*) from car_prices;

-- data cleaning -----
select * from car_prices
where

ï»¿year is null
or
make is null
or
model is null 
or
trim is null
or
body is null
or
vin is null
or
state is null 
or
`condition` is null
or
odometer is null
or
interior is null
or
seller is null
or
mmr is null
or
sellingprice is null
or
saledate is null;

---- data exploration
-- how many models we have ?
select count(*) as model from car_prices;

---- how many uniuque make we have?
select count(distinct model) as make from car_prices;

--- data analysis & business key problems & answers

---- 1Find the top 3 most undervalued cars (where MMR - sellingprice is highest) grouped by make.

SELECT make, model, trim, MAX(mmr - sellingprice) AS max_savings
FROM car_prices
GROUP BY make, model, trim
ORDER BY max_savings DESC
LIMIT 3;

-- 2 Find the top 5 most common car models.

SELECT model, COUNT(*) AS count
FROM car_prices
GROUP BY model
ORDER BY count DESC
LIMIT 5;


---- 3. Find average selling price difference between automatic and non-automatic cars.

SELECT transmission,
       AVG(sellingprice) AS avg_price
FROM car_prices
GROUP BY transmission;

--- 4. Which sellers consistently sell cars below MMR on average?

SELECT seller,
       COUNT(*) AS total_sales,
       AVG(sellingprice - mmr) AS avg_diff
FROM car_prices
GROUP BY seller
HAVING AVG(sellingprice - mmr) < 0
ORDER BY avg_diff ASC;

---- 5--. What is the average selling price of cars by make?

SELECT make, AVG(sellingprice) AS avg_selling_price
FROM car_prices
GROUP BY make
ORDER BY avg_selling_price DESC;

----- 6. Which states have the highest average car condition?

SELECT state, AVG('condition') AS avg_condition
FROM car_prices
GROUP BY state
ORDER BY avg_condition DESC;

---- 7. Get the percentage of cars sold above MMR for each make.

SELECT make,
       COUNT(CASE WHEN sellingprice > mmr THEN 1 END) * 100.0 / COUNT(*) AS percent_above_mmr
FROM car_prices
GROUP BY make
ORDER BY percent_above_mmr DESC;

---- 8. Find the average price difference over time (by month) between MMR and selling price.

SELECT DATE_TRUNC('month', saledate) AS sale_month,
       AVG(mmr - sellingprice) AS avg_price_diff
FROM car_prices
GROUP BY sale_month
ORDER BY sale_month;
--- 9. Compare MMR to selling price to identify potential deals (where selling price is below MMR).

SELECT *, (mmr - sellingprice) AS savings
FROM car_prices
WHERE sellingprice < mmr
ORDER BY savings DESC;

--- end the project ----










