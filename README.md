# 📊 Layoffs Data (2020–2023) - Exploratory Data Analysis using SQL

This project focuses on performing Exploratory Data Analysis (EDA) on a dataset of global layoffs from 2020 to early 2023, using **MySQL**. The dataset contains information on company layoffs, industry sectors, countries affected, funding stages, and more. The project explores patterns and insights into the impact of economic conditions — including the COVID-19 pandemic — on employment across industries and countries.

## 🔍 Project Objective

To uncover trends, patterns, and key statistics using SQL queries — from basic descriptive analysis to advanced analytical queries — to better understand the scope and scale of layoffs during the 2020–2023 period.

---

## 📁 Dataset Description

The dataset contains the following columns:
- `company`: Name of the company.
- `location`: City/region of the company.
- `country`: Country where the layoff occurred.
- `industry`: Industry type.
- `total_laid_off`: Number of people laid off.
- `percentage_laid_off`: % of workforce laid off.
- `funds_raised_millions`: Total funds raised.
- `stage`: Company funding stage (e.g., Series A, Post-IPO).
- `date`: Date of the layoff event.

---

## ⚙️ Technologies Used

- **SQL (MySQL)**
- **DB Browser for SQLite / MySQL Workbench**
- (Optional: Visualization can be done in Excel/Tableau/Power BI based on exported CSV)

---

## 🧠 Key Explorations & Queries

### ✅ Basic Analysis
- Max layoffs in a single event.
- Total layoffs per company.
- Companies that laid off 100% of their staff.
- Companies with the highest funding but still conducted layoffs.

### 🌎 Country and Industry Analysis
- Layoffs by country (e.g., U.S. vs India vs Europe).
- Industries most affected (e.g., Tech, Consumer, Retail).
- Industries least affected (e.g., Legal, Aerospace).

### 📈 Time-Based Analysis
- Layoffs per **year** (2020, 2021, 2022, 2023).
- Layoffs per **month** using substring-based month extraction.
- **Rolling total** of layoffs by month to track cumulative impact.

### 🏢 Company & Stage Analysis
- Layoffs by company funding **stage** (e.g., Series A, IPO).
- Top companies with the most layoffs **per year** using window functions (`DENSE_RANK()`).
- Filtered list of top 5 companies per year based on total layoffs.

---

## 📊 Sample Insights

- Over **383,000** layoffs were recorded across major companies between March 2020 and March 2023.
- **2022** had the highest number of layoffs, but **2023** started off with an alarming number, already reaching **125,000+** in just three months.
- Major tech companies like **Amazon, Meta, Google, Uber, and Salesforce** were among the most impacted.
- Layoffs were most severe in **Consumer, Retail, and Transportation** industries.

---

## 🧠 Advanced SQL Concepts Used

- `GROUP BY` with aggregations (`SUM`, `MAX`)
- `ORDER BY`, filtering (`WHERE`)
- Substrings & date manipulation using `SUBSTRING()` for month/year extraction
- Common Table Expressions (CTEs)
- Window Functions: `DENSE_RANK()` with `PARTITION BY` and `ORDER BY`
- Rolling totals using `OVER(ORDER BY ...)`

---

## 📁 Files in this Repo

| File | Description |
|------|-------------|
| `layoffs.xlsx` | Cleaned dataset with added age brackets |
| `Data Exploratory.sql` | EDA Queries |
