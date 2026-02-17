# 🟢📊💹⚡🌱 Marketing Analytics

*Analyzing marketing performance, customer engagement, conversion trends, and customer feedback*

---

## 📑 Table of Contents
- [1️⃣ Overview](#1-overview)
- [2️⃣ Conversion Details](#2-conversion-details)
- [3️⃣ Social Media Details](#3-social-media-details)
- [4️⃣ Customer Review Details](#4-customer-review-details)
- [🛠️ Tools & Technologies](#tools--technologies)
- [📈 Dashboard Concept](#dashboard-concept)
- [🔄 Project Workflow](#project-workflow)
- [🧱 Project Structure](#project-structure)
- [▶️ How to Run](#how-to-run)
- [🖼️ Data Modeling Diagram](#data-modeling-diagram)
- [📄 PPT / Reports](#ppt--reports)
- [🔍 Key Insights](#key-insights)
- [💡 Business Recommendations](#business-recommendations)
- [💼 Business Value](#business-value)
- [✅ Conclusion](#conclusion)

---

## 1 Overview
![Overview Dashboard](dashboard1.png)

📌 **Purpose:** Analyze digital marketing performance for an online retail business  
👥 **Focus:** Customer engagement, conversion behavior, and feedback trends  
🎯 **Goal:** Identify gaps in marketing effectiveness & optimize ROI  
📊 **Outcome:** Data-driven insights for better business decisions  

**Dashboard Insights:**  
- 📊 **Conversion Rate:** Currently standing at 9.6%, providing a baseline for marketing effectiveness.  
- 📈 **Engagement Volume:** Tracking over 9 million views and 1.7 million clicks across all product categories.  
- ⭐ **Customer Sentiment:** An average rating of 3.69, indicating generally positive feedback with room for service optimization.

---

## 2 Conversion Details
![Conversion Dashboard](dashboard2.png)

📌 **Purpose:** Understand product and campaign performance across the funnel  
👥 **Focus:** Conversion rates by product, category, and seasonal trends  
🎯 **Goal:** Identify drop-offs and optimize the purchase journey  
📊 **Outcome:** Recommendations for improving overall conversions  

**Dashboard Insights:**  
- 🔁 **Conversion Funnel:** Analysis of the customer journey shows 672 views resulting in 355 clicks and 57 final purchases (8.5% conversion rate for the selected period).  
- 📅 **Seasonal Trends:** Conversion rates peak significantly in January (17.3%) and December (12.2%).  
- 🛒 **Top Products:** Ski Boots and Kayaks lead, while Climbing Rope shows the lowest conversion efficiency.

---

## 3 Social Media Details
![Social Media Dashboard](dashboard3.png)

📌 **Purpose:** Track campaign performance and engagement trends  
👥 **Focus:** Channel-level engagement and content-type effectiveness  
🎯 **Goal:** Optimize marketing strategy for maximum reach  
📊 **Outcome:** Identify high-performing content and peak engagement periods  

**Dashboard Insights:**  
- 📣 **Channel Performance:** Views (2.9M), Clicks (458K), Likes (73K) to measure brand awareness.  
- 🎥 **Content Strategy:** Videos consistently drive higher engagement than blogs or social media posts.  
- 📆 **Monthly Reach:** Engagement peaks in April and July, highlighting high-performing campaigns.

---

## 4 Customer Review Details
![Customer Review Dashboard](dashboard4.png)

📌 **Purpose:** Understand customer satisfaction and feedback trends  
👥 **Focus:** Sentiment, ratings, and recurring complaints  
🎯 **Goal:** Improve products and services based on customer insights  
📊 **Outcome:** Implement actionable changes to enhance customer experience  

**Dashboard Insights:**  
- 🧠 **Sentiment Analysis:** Categorized reviews into Positive, Mixed, and Negative sentiments using Python's NLTK (VADER).  
- 🌟 **Rating Distribution:** Majority 4-5 star reviews, but notable "Mixed Negative" cluster in some products.  
- 📝 **Feedback Trends:** Sentiment most positive in December, likely due to successful year-end service initiatives.

---

## Tools & Technologies
- 🐍 **Python** – Data extraction, cleaning, enrichment & export to Power BI  
- 📊 **Pandas** – Data manipulation & transformation  
- 🧠 **NLTK (VADER)** – Sentiment analysis  
- 🔌 **pyodbc** – SQL Server connection  
- 🗄️ **SQL Server** – Data storage  
- 💻 **VS Code** – Python IDE  
- 📁 **CSV Files** – Optional processed export  
- 📊 **Power BI** – Dashboards & visualizations  

---

## Dashboard Concept
- 📌 KPI Overview  
- 📈 Conversion trends  
- 🧪 Campaign & social media performance  
- 📦 Product & category insights  
- 😊 Customer feedback & sentiment visualization  

---

## Project Workflow
🟢 Start: SQL Backup (.bak file)  
        │  
        ▼  
📂 Restore Database & Prepare Tables  
        │  
        ▼  
📝 SQL Tables & Queries  
        │  
        ▼  
🐍 Python Scripts  
  - Cleaning & Enrichment  
  - Sentiment Analysis  
        │  
        ▼  
📄 Export Processed CSV (Used for Data Modeling in Power BI)  
        │  
        ▼  
📊 Connect to Power BI  
  - SQL Queries  
  - Processed CSV (for relationships & visuals)  
        │  
        ▼  
🧮 Build Dashboard & KPIs  
  - One-to-many relationships  
  - Calculated Measures  
        │  
        ▼  
🎯 End: Interactive Dashboard & Insights  

---

## Project Structure
Marketing-Analytics/  
│  
├── sql/  
│   ├── marketing_backup.bak  
│   └── marketing_analysis_queries.sql  
├── python/  
│   ├── data_cleaning.py  
│   └── sentiment_analysis.py  
├── data/  
│   └── processed_data.csv  
├── power_bi/  
│   └── marketing_analytics_dashboard.pbix  
├── dashboard1.png  
├── dashboard2.png  
├── dashboard3.png  
├── dashboard4.png  
├── data_model.png  
├── reports/  
│   └── marketing_report.pptx  
└── README.md  

---

## How to Run
- ⬇️ Clone the repository  
- 📦 Install Python libraries  
- ▶️ Run Python scripts for cleaning & sentiment analysis  
- 🗄️ Connect Power BI to both **processed CSV + SQL queries** to generate dashboards  

---

## Data Modeling Diagram
![Data Model](data_model.png)

---

## PPT / Reports
[Download Detailed PPT Report](reports/marketing_report.pptx)

---

## Key Insights
- 📅 Conversion rates peak seasonally  
- 🔝 Top-performing products identified  
- 📉 Engagement trends across campaigns  
- 🗣️ Customer sentiment impacts sales  

---

## Business Recommendations
- 🎯 Focus on high-performing products & peak seasons  
- 🧪 Optimize underperforming campaigns with targeted strategies  
- ✍️ Align content to boost engagement  
- 🛠️ Address recurring feedback issues  

---

## Business Value
- 📊 Clear visibility into marketing performance  
- 👥 Personalized marketing strategies via customer insights  
- 💰 Optimize budget allocation for higher ROI  
- 🔁 Drive continuous campaign improvements  
- 😊 Enhance brand reputation & customer satisfaction  

---

## Conclusion
- 🧭 End-to-end marketing analytics pipeline implemented  
- 🔍 SQL, Python & Power BI integrated for insights  
- 🚀 Dashboard empowers quick, actionable business decisions  
- 📈 Data-driven strategy improves conversions, engagement & ROI
