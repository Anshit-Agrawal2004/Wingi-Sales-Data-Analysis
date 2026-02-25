DROP TABLE Blinkit_orders;
CREATE TABLE Blinkit_Orders(
Order_Date DATE,
Order_Time TIME,
Order_ID VARCHAR(200),
Customer_ID VARCHAR(200),
City VARCHAR(200),
Product_Category VARCHAR(200),
Order_Status VARCHAR(200),
Payment_Mode VARCHAR(200),
Order_Value FLOAT,
Discount_Applied FLOAT,
Delivery_Time INT,
Customer_Rating FLOAT,
Customer_Cancel_Reason VARCHAR(200),
Seller_Cancel_Reason VARCHAR(200)
);

SELECT * FROM Blinkit_orders;

CREATE VIEW Total_Orders AS
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM blinkit_orders;

SELECT * FROM Total_Orders;

CREATE VIEW Total_Sales AS
SELECT ROUND(SUM(order_value-discount_applied)::NUMERIC,2) AS Total_Sales
FROM blinkit_orders;

SELECT * FROM Total_Sales;

ALTER TABLE blinkit_orders
ADD COLUMN Revenue_after_discount FLOAT;

UPDATE blinkit_orders
SET Revenue_after_discount = ROUND((order_value - discount_applied)::NUMERIC, 2);.

CREATE VIEW Average_order_value_after_discount AS
SELECT ROUND(AVG(revenue_after_discount)::NUMERIC,2)
			AS Average_order_value_after_discount
FROM blinkit_orders;

SELECT * FROM Average_order_value_after_discount;

CREATE VIEW Orders_per_customer AS
SELECT customer_id, COUNT(order_id) AS Orders_per_customer
FROM blinkit_orders
GROUP BY customer_id
ORDER BY Orders_per_customer DESC;

SELECT * FROM Orders_per_customer;

CREATE VIEW Order_status AS
SELECT order_status, COUNT(order_status) AS total_orders
FROM blinkit_orders
GROUP BY order_status;

SELECT * FROM order_status;

CREATE VIEW Weekly_Orders AS
SELECT 
    TO_CHAR(order_date, 'day') AS day_name,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY day_name
ORDER BY total_orders DESC;

SELECT * FROM weekly_orders;

CREATE VIEW hourly_order_trend AS
SELECT EXTRACT(Hour FROM order_time) AS Time_,
		COUNT(*) AS Hourly_Orders
FROM blinkit_orders
GROUP BY time_
ORDER BY time_;

SELECT * FROM hourly_order_trend;

CREATE VIEW Orders_payments AS
SELECT payment_mode, COUNT(*) AS Total_orders
FROM blinkit_orders
GROUP BY payment_mode
ORDER BY Total_orders DESC;

SELECT * FROM Orders_payments;

CREATE VIEW Orders_product_categories AS
SELECT product_category, COUNT(*) AS Total_orders
FROM blinkit_orders
GROUP BY product_category
ORDER BY Total_orders DESC;

SELECT * FROM Orders_product_categories;

CREATE VIEW Average_Delivery_Time AS
SELECT ROUND(AVG(delivery_time)::NUMERIC,2) AS Average_Delivery_Time
FROM blinkit_orders;

SELECT * FROM Average_Delivery_Time;

CREATE VIEW Customer_Cancel_orders AS
SELECT Customer_Cancel_Reason, COUNT(Customer_Cancel_reason) AS Total_Orders
FROM blinkit_orders
GROUP BY Customer_Cancel_Reason
ORDER BY Total_Orders DESC
LIMIT '5';

SELECT * FROM Customer_Cancel_orders;

CREATE VIEW Seller_Cancel_orders AS
SELECT Seller_Cancel_Reason, COUNT(Seller_Cancel_reason) AS Total_Orders
FROM blinkit_orders
GROUP BY Seller_Cancel_Reason
ORDER BY Total_Orders DESC
LIMIT '4';

SELECT * FROM Seller_Cancel_orders;

CREATE VIEW average_order_value_before_discount AS
SELECT ROUND(AVG(order_value)::NUMERIC,2) AS average_order_value_before_discount
FROM blinkit_orders;

SELECT * FROM average_order_value_before_discount;

SELECT 
    Customer_ID,
    COUNT(customer_id) AS Total_Orders,
    CASE 
        WHEN  COUNT(customer_id)= 1 THEN 'New Customer'
        WHEN COUNT(customer_id) BETWEEN 2 AND 4 THEN 'Repeat Customer'
        ELSE 'Loyal Customer'
    END AS Customer_Type
FROM blinkit_orders
GROUP BY customer_id
ORDER BY Total_Orders DESC;


CREATE TABLE blinkit_orders_2(
customer_id VARCHAR(200),
total_orders INT,
customer_type VARCHAR(200)
);
SELECT * FROM blinkit_orders_2;

CREATE VIEW Customer_type AS
SELECT customer_type, COUNT(customer_id) AS Total_customers
FROM blinkit_orders_2
GROUP BY customer_type;

SELECT * FROM Customer_type;

CREATE VIEW Order_Cancel AS
SELECT product_category, COUNT(customer_cancel_reason) AS Orders_Cancel_by_Customers,
		COUNT(seller_cancel_reason) AS Orders_Cancel_by_Seller
FROM blinkit_orders
GROUP BY product_category;

SELECT * FROM Order_cancel;

CREATE VIEW Total_orders_by_products AS
SELECT Product_Category, COUNT(order_id) AS Total_Orders
FROM blinkit_orders
GROUP BY product_category;

SELECT * FROM Total_orders_by_products;