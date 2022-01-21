DROP TABLE IF EXISTS product_sales;
/*Drops the table in case it already exists*/

/*Table Schems*/
CREATE TABLE product_sales(
	Retailer_Country VARCHAR (255),
    Order_Method_Type VARCHAR (255),
    Retailer_Type VARCHAR (255),
    Product_Line VARCHAR (255),
    Product_Type VARCHAR (255),
    Product VARCHAR (255),
    Year_Purchase INT,
    Quarter_Purchase VARCHAR (255),
    Revenue INT,
    Quantity INT,
    Gross_Margin INT NULL
    );
 
 /*Loads data from a csv file*/
LOAD DATA INFILE 'ibm_product_sales.csv' INTO TABLE product_sales
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"' 
    LINES TERMINATED BY '\n' 
    IGNORE 1 LINES;

/*Just to check that everything loaded correctly*/
SELECT * FROM product_sales;

/*Removes rows with null revenue*/
DELETE FROM product_sales
WHERE Revenue IS NULL;

/*Gives the revenue and quantity of products sold per year*/
SELECT Year_Purchase, SUM(Revenue), SUM(Quantity) FROM product_sales
GROUP BY Year_Purchase;

/*Gives the revenue and quantity of products sold per quarter*/
SELECT Quarter_Purchase, SUM(Revenue), SUM(Quantity), Year_Purchase FROM product_sales
GROUP BY Quarter_Purchase
ORDER BY Year_Purchase, Quarter_Purchase;

/*Gives the revenue by country*/
SELECT Retailer_Country, SUM(Revenue) FROM product_sales
GROUP BY Retailer_Country
ORDER BY SUM(Revenue) DESC;

/*Gives the revenue by country by Year*/
SELECT Retailer_Country, SUM(Revenue), Year_Purchase FROM product_sales
GROUP BY Retailer_Country,Year_Purchase
ORDER BY Retailer_Country;
/*TO DO: Convert this into a pivot table*/

/*Gives the revenue by product line*/
SELECT DISTINCT(Product_Line), AVG(Revenue) FROM product_sales
GROUP BY Product_Line
ORDER BY AVG(Revenue) DESC;

/*Gives the top five most selling products*/
SELECT DISTINCT(Product), SUM(Revenue), SUM(Quantity) FROM product_sales
GROUP BY Product
ORDER BY SUM(Quantity) DESC
LIMIT 5;

/*Gives the Average Yearly Revenue (using subqueries)*/
SELECT AVG(Sum_Table) FROM (
	SELECT Year_Purchase, SUM(Revenue) AS Sum_Table FROM product_sales
    GROUP BY Year_Purchase) 
Avg_Table;