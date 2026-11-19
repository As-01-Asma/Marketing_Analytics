USE PortfolioProject_MarketingAnalytics;
GO

/*========================================================
  MARKETING ANALYTICS
  SQL DATA VALIDATION

  Purpose:
  Validate data cleaning, business KPIs and calculations.
========================================================*/


/*========================================================
  1. CUSTOMER JOURNEY DATA CLEANING

  Validation Status: VERIFIED
  Original Records: 4,011
  Cleaned Records: 3,932
  Removed Records: 79

  Result: Duplicate-removal logic was validated.
========================================================*/

WITH Cleaned_Data AS
(
    SELECT
        JourneyID,
        ROW_NUMBER() OVER
        (
            PARTITION BY
                CustomerID,
                ProductID,
                VisitDate,
                UPPER(Stage),
                Action
            ORDER BY JourneyID
        ) AS row_num
    FROM dbo.customer_journey
)
SELECT
    COUNT(*) AS Original_Rows,
    SUM(CASE WHEN row_num = 1 THEN 1 ELSE 0 END)
        AS Cleaned_Rows,
    SUM(CASE WHEN row_num > 1 THEN 1 ELSE 0 END)
        AS Removed_Rows
FROM Cleaned_Data;


/*========================================================
  2. AVERAGE CUSTOMER RATING

  Validation Status: CHECKED
  Power BI Average Rating: 3.69

  Result: Calculated the SQL average rating and
  compared it with the Power BI result.
========================================================*/

SELECT
    AVG(CAST(Rating AS DECIMAL(10,4))) AS Actual_SQL_Value,
    ROUND(
        AVG(CAST(Rating AS DECIMAL(10,4))), 2
    ) AS Rounded_SQL_Value,
    CAST(3.69 AS DECIMAL(10,2)) AS PowerBI_Value
FROM dbo.customer_reviews;


/*========================================================
  3. OVERALL CONVERSION RATE

  Validation Status: VERIFIED
  Total Views: 2,070
  Total Purchases: 198
  SQL Conversion Rate: 9.57%
  Power BI Conversion Rate: 9.60%

  Result: SQL and Power BI values matched
  after rounding.
========================================================*/

WITH Cleaned_Data AS
(
    SELECT
        JourneyID,
        Action,
        ROW_NUMBER() OVER
        (
            PARTITION BY
                CustomerID,
                ProductID,
                VisitDate,
                UPPER(Stage),
                Action
            ORDER BY JourneyID
        ) AS row_num
    FROM dbo.customer_journey
),
Conversion_Data AS
(
    SELECT
        COUNT(DISTINCT CASE
            WHEN Action = 'View' THEN JourneyID
        END) AS Total_Visitors,

        COUNT(DISTINCT CASE
            WHEN Action = 'Purchase' THEN JourneyID
        END) AS Total_Purchases
    FROM Cleaned_Data
    WHERE row_num = 1
)
SELECT
    Total_Visitors,
    Total_Purchases,
    CAST(
        Total_Purchases * 100.0 /
        NULLIF(Total_Visitors, 0)
        AS DECIMAL(10,2)
    ) AS Conversion_Rate
FROM Conversion_Data;


/*========================================================
  4. CUSTOMER DROP-OFF RATE

  Validation Status: VERIFIED
  Total Views: 2,070
  Total Drop-offs: 598
  SQL Drop-off Rate: 28.89%
  Power BI Drop-off Rate: 28.90%

  Result: SQL and Power BI values matched
  after rounding.
========================================================*/

WITH Cleaned_Data AS
(
    SELECT
        JourneyID,
        Action,
        ROW_NUMBER() OVER
        (
            PARTITION BY
                CustomerID,
                ProductID,
                VisitDate,
                UPPER(Stage),
                Action
            ORDER BY JourneyID
        ) AS row_num
    FROM dbo.customer_journey
),
Dropoff_Data AS
(
    SELECT
        COUNT(DISTINCT CASE
            WHEN Action = 'View' THEN JourneyID
        END) AS Total_Visitors,

        COUNT(DISTINCT CASE
            WHEN Action = 'Drop-off' THEN JourneyID
        END) AS Total_Dropoffs
    FROM Cleaned_Data
    WHERE row_num = 1
)
SELECT
    Total_Visitors,
    Total_Dropoffs,
    CAST(
        Total_Dropoffs * 100.0 /
        NULLIF(Total_Visitors, 0)
        AS DECIMAL(10,2)
    ) AS Dropoff_Rate
FROM Dropoff_Data;


/*========================================================
  5. JANUARY VS OCTOBER CONVERSION RATE

  Validation Status: VERIFIED
  January Conversion: 17.31%
  October Conversion: 6.15%
  Conversion Growth: 181.46%

  Result: Monthly conversion rates were compared
  with Power BI after rounding.
========================================================*/

WITH Cleaned_Data AS
(
    SELECT
        JourneyID,
        VisitDate,
        Action,
        ROW_NUMBER() OVER
        (
            PARTITION BY
                CustomerID,
                ProductID,
                VisitDate,
                UPPER(Stage),
                Action
            ORDER BY JourneyID
        ) AS row_num
    FROM dbo.customer_journey
),
Monthly_Data AS
(
    SELECT
        MONTH(VisitDate) AS Month_Number,

        COUNT(DISTINCT CASE
            WHEN Action = 'View' THEN JourneyID
        END) AS Total_Visitors,

        COUNT(DISTINCT CASE
            WHEN Action = 'Purchase' THEN JourneyID
        END) AS Total_Purchases

    FROM Cleaned_Data
    WHERE row_num = 1
      AND MONTH(VisitDate) IN (1, 10)
    GROUP BY MONTH(VisitDate)
),
Monthly_Rates AS
(
    SELECT
        Month_Number,
        CAST(
            Total_Purchases * 100.0 /
            NULLIF(Total_Visitors, 0)
            AS DECIMAL(10,4)
        ) AS Conversion_Rate
    FROM Monthly_Data
),
Comparison AS
(
    SELECT
        MAX(CASE
            WHEN Month_Number = 1
            THEN Conversion_Rate
        END) AS January_Rate,

        MAX(CASE
            WHEN Month_Number = 10
            THEN Conversion_Rate
        END) AS October_Rate
    FROM Monthly_Rates
)
SELECT
    January_Rate,
    October_Rate,

    CAST(
        (January_Rate - October_Rate) * 100.0 /
        NULLIF(October_Rate, 0)
        AS DECIMAL(10,2)
    ) AS Conversion_Growth_Percent

FROM Comparison;


/*========================================================
  6. HIGHEST-PERFORMING CONTENT TYPE BY TOTAL LIKES

  Validation Status: VERIFIED
  Top Content Type: Blog

  Result: Blog recorded the highest total likes
  among all content types.
========================================================*/

WITH Content_Likes AS
(
    SELECT
        ContentType,
        SUM(Likes) AS Total_Likes
    FROM dbo.engagement_data
    GROUP BY ContentType
)
SELECT TOP 1
    ContentType,
    Total_Likes
FROM Content_Likes
ORDER BY Total_Likes DESC;


/*========================================================
  7. SKI BOOTS JANUARY CONVERSION RATE

  Validation Status: VERIFIED
  Product: Ski Boots
  Month: January
  Conversion Rate: 100%

  Result: January conversion rate was calculated
  using the original customer journey records.
========================================================*/

WITH Product_Data AS
(
    SELECT
        p.ProductName,
        cj.JourneyID,
        cj.Action

    FROM dbo.customer_journey AS cj

    INNER JOIN dbo.products AS p
        ON cj.ProductID = p.ProductID

    WHERE p.ProductName = 'Ski Boots'
      AND MONTH(cj.VisitDate) = 1
),
Conversion_Data AS
(
    SELECT
        COUNT(DISTINCT CASE
            WHEN Action = 'View' THEN JourneyID
        END) AS Total_Visitors,

        COUNT(DISTINCT CASE
            WHEN Action = 'Purchase' THEN JourneyID
        END) AS Total_Purchases

    FROM Product_Data
)
SELECT
    Total_Visitors,
    Total_Purchases,

    CAST(
        Total_Purchases * 100.0 /
        NULLIF(Total_Visitors, 0)
        AS DECIMAL(10,2)
    ) AS Conversion_Rate

FROM Conversion_Data;


/*========================================================
  END OF SQL DATA VALIDATION
========================================================*/
