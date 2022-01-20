DROP TABLE product_sales;
/*Drops the table in case it already exists*/

CREATE TABLE product_sales(
	Retailer_Country VARCHAR (200),
    Order_Method_Type VARCHAR (200),
    Retailer_Type VARCHAR (200),
    Product_Line VARCHAR (200),
    Product_Type VARCHAR (200),
    Product VARCHAR (200),
    Year_Purchase INT,
    Quarter_Purchase VARCHAR (200),
    Revenue INT,
    Quantity INT,
    Gross_Margin INT NULL
    );
    
LOAD DATA INFILE 'ibm_product_sales.csv' INTO TABLE product_sales
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"' 
    LINES TERMINATED BY '\n' 
    IGNORE 1 LINES;

SELECT * FROM product_sales;

/*Gives the revenue and quantity of products sold per year*/
SELECT Year_Purchase, SUM(Revenue), SUM(Quantity) FROM product_sales
GROUP BY Year_Purchase;

/*Gives the revenue and quantity of products sold per quarter*/
SELECT Quarter_Purchase, SUM(Revenue), SUM(Quantity) FROM product_sales
GROUP BY Quarter_Purchase
ORDER BY Quarter_Purchase;

/*Gives the revenue by country*/
SELECT Retailer_Country, SUM(Revenue) FROM product_sales
GROUP BY Retailer_Country
ORDER BY SUM(Revenue) DESC;

/*Gives the revenue by country by Year*/
SELECT Retailer_Country, SUM(Revenue), Year_Purchase FROM product_sales
GROUP BY Retailer_Country,Year_Purchase
ORDER BY Retailer_Country;
/*Convert this into a pivot table*/

/*Gives the revenue by country by Year of the Top 5 countries with highest revenue
  using subqueries*/

/*Gives the revenue by product line*/
SELECT DISTINCT(Product_Line), AVG(Revenue) FROM product_sales
GROUP BY Product_Line
ORDER BY AVG(Revenue) DESC;

/*Golf equipment was the product line with largest revenue.
This gives the list of products and their avg revenue in that product line*/
