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

- **🎯 Purpose:** Analyze digital marketing performance for an online retail business  
- **👥 Focus:** Customer engagement, conversion behavior, and feedback trends  
- **📉 Goal:** Identify gaps in marketing effectiveness & optimize ROI  
- **📊 Outcome:** Data-driven insights for better business decisions  

**Dashboard Insights:**  
- 📊 Conversion Rate: Currently standing at 9.6%, providing a baseline for marketing effectiveness.  
- 👀 Engagement Volume: Tracking over 9 million views and 1.7 million clicks across all product categories.  
- ⭐ Customer Sentiment: An average rating of 3.69, indicating generally positive feedback with room for service optimization.

---

## 2 Conversion Details
![Conversion Dashboard](dashboard2.png)

- **🎯 Purpose:** Track and optimize the conversion of potential customers into buyers  
- **👥 Focus:** Identify top-performing products, categories, and seasonal trends  
- **📉 Goal:** Reduce drop-offs in the conversion funnel & increase overall purchases  
- **📊 Outcome:** Insights to improve campaigns and maximize revenue  

**Dashboard Insights:**  
- 🔁 Conversion Funnel: 672 views → 355 clicks → 57 final purchases (8.5% conversion rate).  
- 📅 Seasonal Trends: Peaks in January (17.3%) and December (12.2%), highlighting holiday marketing impact.  
- 🛒 Top Products: Ski Boots and Kayaks lead, Climbing Rope has lowest conversion efficiency.

---

## 3 Social Media Details
![Social Media Dashboard](dashboard3.png)

- **🎯 Purpose:** Measure campaign effectiveness across social channels  
- **👥 Focus:** Track engagement metrics (clicks, likes, shares) and monthly trends  
- **📉 Goal:** Identify high-performing content and campaign timing  
- **📊 Outcome:** Insights to guide content strategy and maximize reach  

**Dashboard Insights:**  
- 📊 Channel Performance: Views (2.9M), Clicks (458K), Likes (73K) measure brand awareness.  
- 🎥 Content Strategy: Videos consistently drive higher engagement peaks in mid-year.  
- 📅 Monthly Reach: Peaks in April and July indicate strong campaigns during these windows.

---

## 4 Customer Review Details
![Customer Review Dashboard](dashboard4.png)

- **🎯 Purpose:** Understand customer feedback and product perception  
- **👥 Focus:** Analyze sentiment scores, ratings, and recurring complaints  
- **📉 Goal:** Improve products, services, and customer satisfaction  
- **📊 Outcome:** Data-driven recommendations for enhancing brand reputation  

**Dashboard Insights:**  
- 🧠 Sentiment Analysis: Categorized reviews into Positive, Mixed, and Negative using Python NLTK (VADER).  
- ⭐ Rating Distribution: Majority 4-5 star, some “Mixed Negative” in specific categories.  
- 📈 Feedback Trends: Sentiment most positive in December due to successful year-end initiatives.

---

## Tools & Technologies
- 🐍 Python – Data extraction, cleaning, enrichment & export to Power BI  
- 📊 Pandas – Data manipulation & transformation  
- 🧠 NLTK (VADER) – Sentiment analysis  
- 🔌 pyodbc – SQL Server connection  
- 🗄️ SQL Server – Data storage  
- 💻 VS Code – Python IDE  
- 📁 CSV Files – Optional processed export  
- 📊 Power BI – Dashboards & visualizations  

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
