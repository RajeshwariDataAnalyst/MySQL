USE ecomm;

SELECT * from customer_churn;

-- 1. Data Cleaing
 
-- Delete Outliers

SET SQL_SAFE_UPDATES = 0;

DELETE FROM customer_churn
WHERE WarehouseToHome > 100;

-- Impute Mean values 

SET @avg_Warehousetohome = (SELECT Avg(WarehouseToHome)
FROM customer_churn
WHERE WarehouseToHome IS NOT NULL);
 
UPDATE customer_churn SET WarehouseToHome = @avg_Warehousetohome
WHERE WarehouseToHome IS NULL;


SET @avg_HourSpendOnApp = (SELECT Avg(HourSpendOnApp)
FROM customer_churn
WHERE HourSpendOnApp IS NOT NULL);
 
UPDATE customer_churn SET HourSpendOnApp = @avg_HourSpendOnApp
WHERE HourSpendOnApp IS NULL;
 

SET @avg_OrderAmountHikeFromlastYear = (SELECT Avg(OrderAmountHikeFromlastYear)
FROM customer_churn
WHERE OrderAmountHikeFromlastYear IS NOT NULL);
 
UPDATE customer_churn SET OrderAmountHikeFromlastYear = @avg_OrderAmountHikeFromlastYear
WHERE OrderAmountHikeFromlastYear IS NULL;
 
SET @avg_DaySinceLastOrder = (SELECT Avg(DaySinceLastOrder)
FROM customer_churn
WHERE DaySinceLastOrder IS NOT NULL);
 
UPDATE customer_churn SET DaySinceLastOrder = @avg_DaySinceLastOrder
WHERE DaySinceLastOrder IS NULL;
 
 -- Impute Mode to Replace null value
 
SET SQL_SAFE_UPDATES = 0;
 
UPDATE customer_churn 
SET Tenure = (SELECT C.Tenure FROM
              ( SELECT Tenure FROM customer_churn
              GROUP BY Tenure
              ORDER BY COUNT(*) DESC
              LIMIT 1) AS C	
              )
WHERE Tenure IS NULL;               


UPDATE customer_churn 
SET CouponUsed = (SELECT C.CouponUsed FROM 
				 ( SELECT CouponUsed FROM customer_churn
                 GROUP BY CouponUsed 
                 ORDER BY COUNT(*) DESC
                 LIMIT 1) AS C
                 )
WHERE CouponUsed IS NULL;                

UPDATE customer_churn
SET OrderCount = (SELECT C.OrderCount FROM 
                 (SELECT OrderCount FROM customer_churn
                 GROUP BY OrderCount 
                 ORDER BY COUNT(*) DESC
                 LIMIT 1) AS C
                 )
WHERE OrderCount IS NULL;    

-- Dealing with Inconsistence

SET SQL_SAFE_UPDATES = 0;

UPDATE customer_churn
SET PreferredLoginDevice = 'Mobile Phone'
WHERE PreferredLoginDevice = 'Phone';

UPDATE customer_churn 
SET PreferedOrderCat = 'Mobile Phone'
WHERE PreferedOrderCat = 'Mobile';


UPDATE customer_churn
SET PreferredPaymentMode = 'Cash On Delivery'
WHERE PreferredPaymentMode = 'COD';

UPDATE customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';

-- 2. Data Transformation

-- Column Renaming

ALTER TABLE customer_churn RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;

ALTER TABLE customer_churn RENAME COLUMN HourSpendOnApp TO HoursSpendOnApp;

-- Creating New Column

ALTER TABLE customer_churn
ADD COLUMN ComplaintReceived VARCHAR(10);

UPDATE customer_churn
SET ComplaintReceived = IF(Complain = 1, 'Yes', 'No');

ALTER TABLE customer_churn
ADD COLUMN ChurnStatus VARCHAR(15);

UPDATE customer_churn
SET ChurnStatus = IF(Churn = 1, 'Churned', 'Active');

-- Drop The Columns

ALTER TABLE customer_churn
DROP COLUMN Complain,
DROP COLUMN Churn;

-- 3. Data Exploration & Analysis

-- Retrieve Churn Count 

SELECT ChurnStatus, COUNT(*) AS Count_Of_ChurnStatus
FROM customer_churn 
GROUP BY ChurnStatus;

-- Avg of Tenure & Total Cashback with condition of who "churned"

SELECT ChurnStatus, ROUND(AVG(Tenure),2) AS Avg_Tenure,
       SUM(CashbackAmount) AS Tlt_Cashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';

-- Perchantage of Churned customer with complaint Received

SELECT ChurnStatus, ROUND((SUM( CASE WHEN ComplaintReceived = 'Yes' THEN 1 ELSE 0 END) * 100) / COUNT(*),2)
		AS Percentage_Churned_Customer
FROM customer_churn
WHERE ChurnStatus = 'Churned';

-- Highest No of City tier who purchased laptop & accessory

SELECT CityTier, PreferredOrderCat, COUNT(*) AS churned_laptop_customers
FROM customer_churn
WHERE ChurnStatus = 'Churned'
  AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY churned_laptop_customers DESC
LIMIT 1;

-- Most preferred payment mode among "Active" customers

SELECT PreferredPaymentMode,ChurnStatus, COUNT(*) AS Count_of_PaymentMode
FROM customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode 
ORDER BY Count_of_PaymentMode DESC
LIMIT 1;

-- Calculate the total order amount hike from last year who are single and preferred mobile phone

SELECT MaritalStatus, PreferredOrderCat, SUM(OrderAmountHikeFromlastYear) AS SUM_OF_HIKE_LASTYEAR
FROM customer_churn
WHERE MaritalStatus = 'Single'
  AND PreferredOrderCat = 'Mobile Phone';
  
-- Average number of devices registered who preferred UPI payment mode
  
SELECT PreferredPaymentMode, ROUND(AVG(NumberOfDeviceRegistered),2) AS Avg_of_DeviceRegistered
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';
  
-- City tier with the highest number of customers
  
SELECT CityTier, COUNT(CustomerID) AS Count_CustomerID
FROM customer_churn
GROUP BY CityTier
ORDER BY Count_CustomerID DESC
LIMIT 1;
  
-- Identify the gender that utilized the highest number of coupons

SELECT Gender, SUM(CouponUsed) AS Highest_CouponUsed
FROM customer_churn
GROUP BY Gender
ORDER BY Highest_CouponUsed DESC
LIMIT 1;

-- number of customers spent maximum hours on the app and preferred order category.

SELECT PreferredOrderCat, COUNT(CustomerID) AS No_of_Customer,
	   MAX(HoursSpendOnApp) AS MAX_Hrs_spendOnApp
FROM customer_churn
GROUP BY PreferredOrderCat;

-- total order count for customers who prefer using credit cards and have the max satisfaction score.

SELECT PreferredPaymentMode, SUM(OrderCount) AS Ttl_no_of_OrderCount
FROM customer_churn
WHERE PreferredPaymentMode = 'Credit Card'
  AND SatisfactionScore = (
      SELECT MAX(SatisfactionScore)
      FROM customer_churn
      WHERE PreferredPaymentMode = 'Credit Card'
  );
  
-- average satisfaction score of customers who have complained

SELECT ComplaintReceived,ROUND(AVG(SatisfactionScore),2) AS Avg_SatisfactionScore 
FROM customer_churn
WHERE ComplaintReceived = 'YES';

-- preferred order category among customers who used more than 5 coupons

SELECT PreferredOrderCat, COUNT(*) AS No_Customer
FROM customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat
ORDER BY No_Customer;

-- Top 3 preferred order categories with the highest average cashback

SELECT PreferredOrderCat, ROUND(AVG(CashbackAmount),2) AS Highest_cashback
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY Highest_cashback DESC
LIMIT 3;

-- The preferred payment modes of customers whose avg tenure 10 months have placed more than 500 orders.

SELECT PreferredPaymentMode,
       COUNT(OrderCount) AS total_order
FROM customer_churn
GROUP BY PreferredPaymentMode
HAVING round(AVG(Tenure)) = 10
   AND total_order > 500;

-- Categorize customers based on their distance from the warehouse to home 

SELECT 
    CASE 
        WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
        WHEN WarehouseToHome <= 10 THEN 'Close Distance'
        WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
    END AS Distance_HometoWarehouse,
    ChurnStatus,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY Distance_HometoWarehouse, ChurnStatus
ORDER BY Distance_HometoWarehouse;

-- Order details who are married,in City Tier-1, and ordercounts more than the avg of orders placed by all customers

SELECT MaritalStatus, COUNT(MaritalStatus), CityTier
FROM customer_churn
WHERE MaritalStatus = 'Married'
  AND CityTier = 1
  AND OrderCount > (
        SELECT AVG(OrderCount)
        FROM customer_churn
      );

-- Insert Customer_Returns Table

CREATE TABLE Customer_Returns (
ReturnID        INT PRIMARY KEY,
CustomerID      INT, 
ReturnDate      DATE,
RefundAmount    INT,

FOREIGN KEY (CustomerID) REFERENCES customer_churn (CustomerID)
);

-- Insert Values in Customer_returns table

INSERT INTO Customer_Returns(ReturnID, CustomerID, ReturnDate, RefundAmount) VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);

-- Display return details along with the customer details of who have churned and have made complaints.

SELECT R.ReturnID, R.CustomerID, R.ReturnDate, R.RefundAmount, C.ChurnStatus, C.ComplaintReceived
FROM Customer_Returns AS R
JOIN customer_churn AS C
   ON C.CustomerID = R.CustomerID
WHERE ChurnStatus = 'Churned'
  AND ComplaintReceived = 'Yes';   







 
 