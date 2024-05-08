-- exploratory_data_analysis

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1 
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`) AS min_date, MAX(`date`) AS max_date
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT company, industry, total_laid_off, country, funds_raised_millions 
FROM layoffs_staging2
WHERE country LIKE '%myanmar%';

SELECT company, industry, total_laid_off, country, funds_raised_millions 
FROM layoffs_staging2
WHERE country LIKE '%thai%';

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 ASC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

#---------------------------------------------------------------------------------------------------------------------------------------------------

SELECT substring(`date`, 1,7) AS `Month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_Total AS
(
SELECT substring(`date`, 1,7) AS `Month`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off, SUM(total_off) OVER (ORDER BY `MONTH`) AS Rolling_Total
FROM Rolling_Total;

#---------------------------------------------------------------------------------------------------------------------------------------------------

SELECT company, YEAR(`date`), SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY  total_laid_off DESC) AS Ranking
FROM Company_year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
),
company_year_rank AS 
(
SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY  total_laid_off DESC) AS Ranking
FROM Company_year
WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE Ranking <= 5;
#----------------------------------------------------------------------------------------------------------------------------------------


















