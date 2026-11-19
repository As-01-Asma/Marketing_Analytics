USE PortfolioProject_MarketingAnalytics;
GO

/*========================================================
  MARKETING ANALYTICS
  SQL DATA VALIDATION REPORT

  Purpose:
  Validate data cleaning, business KPIs and calculations.
  Compare SQL results with Power BI where applicable.
========================================================*/


/*========================================================
  1. CUSTOMER JOURNEY DATA CLEANING

  Check:
  Compare the original source records with the cleaned
  records after applying duplicate-removal logic.
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
),
Counts AS
(
    SELECT
        (SELECT COUNT(*)
         FROM dbo.customer_journey) AS Actual_Original_Rows,

        (SELECT COUNT(*)
         FROM Cleaned_Data
         WHERE row_num = 1) AS Actual_Cleaned_Rows
)
SELECT
    'Customer Journey Data Cleaning' AS KPI_Name,
    Actual_Original_Rows,
    Actual_Cleaned_Rows,
    Actual_Original_Rows - Actual_Cleaned_Rows AS Removed_Rows,

    CASE
        WHEN Actual_Original_Rows = 4011
         AND Actual_Cleaned_Rows = 3932
        THEN 'PASS'
        ELSE 'REVIEW REQUIRED'
    END AS Validation_Status
FROM Counts;


/*========================================================
  2. AVERAGE CUSTOMER RATING

  Check:
  Calculate the exact SQL average and compare its
  rounded value with the Power BI result.
========================================================*/

WITH SQL_Result AS
(
    SELECT
        AVG(CAST(Rating AS DECIMAL(10,4))) AS Actual_Value
    FROM dbo.customer_reviews
)
SELECT
    'Average Customer Rating' AS KPI_Name,
    Actual_Value AS Actual_SQL_Value,
    ROUND(Actual_Value, 2) AS Rounded_SQL_Value,
    CAST(3.69 AS DECIMAL(10,2)) AS PowerBI_Value,

    ROUND(
        ABS(ROUND(Actual_Value, 2) - 3.69), 2
    ) AS Difference,

    CASE
        WHEN ROUND(Actual_Value, 2) = 3.69
        THEN 'PASS - MATCH AFTER ROUNDING'
        ELSE 'REVIEW REQUIRED'
    END AS Validation_Status
FROM SQL_Result;


/*========================================================
  3. OVERALL CONVERSION RATE

  Check:
  Calculate conversion rate using distinct JourneyIDs
  after applying the same cleaning logic as Power BI.
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
),
SQL_Result AS
(
    SELECT
        Total_Visitors,
        Total_Purchases,

        CAST(
            Total_Purchases * 100.0 /
            NULLIF(Total_Visitors, 0)
            AS DECIMAL(10,4)
        ) AS Actual_Value
    FROM Conversion_Data
)
SELECT
    'Overall Conversion Rate' AS KPI_Name,
    Total_Visitors,
    Total_Purchases,
    Actual_Value AS Actual_SQL_Value,
    ROUND(Actual_Value, 2) AS Rounded_SQL_Value,
    CAST(9.60 AS DECIMAL(10,2)) AS PowerBI_Value,

    ROUND(
        ABS(ROUND(Actual_Value, 2) - 9.60), 2
    ) AS Difference,

    CASE
        WHEN ROUND(Actual_Value, 1) = 9.6
        THEN 'PASS - MATCH AFTER ROUNDING'
        ELSE 'REVIEW REQUIRED'
    END AS Validation_Status
FROM SQL_Result;


/*========================================================
  4. CUSTOMER DROP-OFF RATE

  Check:
  Calculate drop-off rate using distinct JourneyIDs
  and compare it with the Power BI result.
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
),
SQL_Result AS
(
    SELECT
        Total_Visitors,
        Total_Dropoffs,

        CAST(
            Total_Dropoffs * 100.0 /
            NULLIF(Total_Visitors, 0)
            AS DECIMAL(10,4)
        ) AS Actual_Value
    FROM Dropoff_Data
)
SELECT
    'Customer Drop-off Rate' AS KPI_Name,
    Total_Visitors,
    Total_Dropoffs,
    Actual_Value AS Actual_SQL_Value,
    ROUND(Actual_Value, 2) AS Rounded_SQL_Value,
    CAST(28.90 AS DECIMAL(10,2)) AS PowerBI_Value,

    ROUND(
        ABS(ROUND(Actual_Value, 2) - 28.90), 2
    ) AS Difference,

    CASE
        WHEN ROUND(Actual_Value, 1) = 28.9
        THEN 'PASS - MATCH AFTER ROUNDING'
        ELSE 'REVIEW REQUIRED'
    END AS Validation_Status
FROM SQL_Result;


/*========================================================
  5. JANUARY VS OCTOBER CONVERSION RATE

  Check:
  Compare January and October conversion rates with
  Power BI and calculate growth from October to January.
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
    'January vs October Conversion' AS KPI_Name,

    January_Rate AS Actual_January_SQL,
    ROUND(January_Rate, 2) AS Rounded_January_SQL,
    CAST(17.30 AS DECIMAL(10,2)) AS January_PowerBI_Value,

    October_Rate AS Actual_October_SQL,
    ROUND(October_Rate, 2) AS Rounded_October_SQL,
    CAST(6.10 AS DECIMAL(10,2)) AS October_PowerBI_Value,

    CAST(
        (January_Rate - October_Rate) * 100.0 /
        NULLIF(October_Rate, 0)
        AS DECIMAL(10,2)
    ) AS Actual_Growth_Percent,

    CASE
        WHEN ROUND(January_Rate, 1) = 17.3
         AND ROUND(October_Rate, 1) = 6.1
        THEN 'PASS - MONTHLY RATES MATCH AFTER ROUNDING'
        ELSE 'REVIEW REQUIRED'
    END AS Validation_Status

FROM Comparison;


/*========================================================
  6. HIGHEST-PERFORMING CONTENT TYPE BY TOTAL LIKES

  Check:
  Group engagement records by content type and identify
  the content type with the highest total likes.
========================================================*/

WITH Content_Likes AS
(
    SELECT
        ContentType,
        SUM(Likes) AS Total_Likes
    FROM dbo.engagement_data
    GROUP BY ContentType
),
Top_Content AS
(
    SELECT TOP 1
        ContentType,
        Total_Likes
    FROM Content_Likes
    ORDER BY Total_Likes DESC
)
SELECT
    'Highest Total Likes by Content Type' AS KPI_Name,
    ContentType AS Actual_Top_Content_Type,
    Total_Likes AS Actual_Total_Likes,

    CASE
        WHEN ContentType = 'Blog'
        THEN 'PASS'
        ELSE 'REVIEW REQUIRED'
    END AS Validation_Status

FROM Top_Content;


/*========================================================
  7. SKI BOOTS JANUARY CONVERSION RATE

  Check:
  Calculate the January conversion rate for Ski Boots
  using the original customer journey source table.

  Uses January records across all available years.
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
),
SQL_Result AS
(
    SELECT
        Total_Visitors,
        Total_Purchases,

        CAST(
            Total_Purchases * 100.0 /
            NULLIF(Total_Visitors, 0)
            AS DECIMAL(10,4)
        ) AS Actual_Value

    FROM Conversion_Data
)
SELECT
    'Ski Boots January Conversion Rate' AS KPI_Name,
    Total_Visitors,
    Total_Purchases,
    Actual_Value AS Actual_SQL_Value,
    ROUND(Actual_Value, 2) AS Rounded_SQL_Value,
    CAST(100.00 AS DECIMAL(10,2)) AS PowerBI_Value,

    ROUND(
        ABS(ROUND(Actual_Value, 2) - 100.00), 2
    ) AS Difference,

    CASE
        WHEN ROUND(Actual_Value, 2) = 100.00
        THEN 'PASS - MATCH'
        ELSE 'REVIEW REQUIRED'
    END AS Validation_Status

FROM SQL_Result;


/*========================================================
  END OF SQL DATA VALIDATION REPORT
========================================================*/