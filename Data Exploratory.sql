-- ============================================
-- Exploratory Data Analysis on Layoffs Dataset
-- ============================================

-- View full dataset after cleaning
SELECT *
FROM layoffs_staging2;

-- Check the maximum values of total and percentage laid off
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Get companies with 100% layoffs, ordered by funds raised
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Total layoffs by company (aggregated)
SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;

-- Identify the date range in the dataset
SELECT MIN(`date`) AS start_date, MAX(`date`) AS end_date
FROM layoffs_staging2;

-- Total layoffs by industry
SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_laid_off DESC;

-- Total layoffs by country
SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;

-- Yearly layoffs trend
SELECT YEAR(`date`) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY year DESC;

-- Layoffs by company funding stage
SELECT stage, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_laid_off DESC;

-- Repetition: Total layoffs by company (already executed earlier)
-- Included again in case further drilldown/joins are needed
SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;

-- Monthly layoffs trend (YYYY-MM)
SELECT SUBSTR(`date`,1,7) AS `Month`, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE SUBSTR(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY `Month` ASC;

-- Rolling total of layoffs over time (month-by-month cumulative sum)
WITH Rolling_Total AS (
    SELECT SUBSTR(`date`,1,7) AS `Month`, SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE SUBSTR(`date`,1,7) IS NOT NULL
    GROUP BY `Month`
    ORDER BY `Month` ASC
)
SELECT `Month`, total_off,
       SUM(total_off) OVER(ORDER BY `Month`) AS rolling_total
FROM Rolling_Total;

-- Yearly layoffs per company
SELECT company, YEAR(`date`) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY total_laid_off DESC;

-- Ranking companies by layoffs within each year
WITH Company_Year (company, years, total_laid_off) AS (
    SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
)
SELECT *, 
       DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL;

-- Top 5 companies with the most layoffs per year
WITH Company_Year (company, years, total_laid_off) AS (
    SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
), 
Company_Year_Rank AS (
    SELECT *, 
           DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
    FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT * 
FROM Company_Year_Rank
WHERE Ranking <= 5;

-- Total layoffs by stage per country
SELECT 
    country,
    stage,
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country, stage
ORDER BY country, total_laid_off DESC;


-- Total layoffs by industry (for percentage calculation)
WITH Industry_Layoffs AS (
    SELECT 
        industry,
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY industry
), Total AS (
    SELECT SUM(total_laid_off) AS global_total FROM Industry_Layoffs
)
SELECT 
    i.industry,
    i.total_laid_off,
    ROUND((i.total_laid_off / t.global_total) * 100, 2) AS percentage_of_total
FROM Industry_Layoffs i, Total t
ORDER BY percentage_of_total DESC;

-- Fund stage % of total layoffs
WITH Stage_Layoffs AS (
    SELECT 
        stage,
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY stage
), Total AS (
    SELECT SUM(total_laid_off) AS global_total FROM Stage_Layoffs
)
SELECT 
    s.stage,
    s.total_laid_off,
    ROUND((s.total_laid_off / t.global_total) * 100, 2) AS percentage_of_total
FROM Stage_Layoffs s, Total t
ORDER BY percentage_of_total DESC;