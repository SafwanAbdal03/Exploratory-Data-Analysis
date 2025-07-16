# Layoffs Data Analysis

## Overview  
This project explores a dataset of company layoffs to uncover trends and key insights over time. Using a series of SQL scripts, we clean and standardize fields, then perform aggregations, rankings, and rolling totals to answer business questions such as:

- Which companies and industries experienced the most layoffs?  
- How have layoffs varied by country and month?  
- What are the top-5 companies with the highest layoffs each year?  

## Data Preparation  
1. **Trim & standardize fields**  
   - Remove extra whitespace from company names  
   - Normalize industry labels (e.g. “Crypto”)  
   - Unify country names (“United States”)  
2. **Convert date strings**  
   - Parse `MM/DD/YY` strings into proper `DATE` values  
   - Alter the column type to `DATE`  

3. **Clean up**  
   - Identify and delete rows with missing layoff counts  

## Key Analysis Queries  
- **Max values & top records**  
  ```sql
  SELECT MAX(total_laid_off), MAX(percentage_laid_off) …  
  SELECT * FROM layoffs_staging2 ORDER BY percentage_laid_off DESC LIMIT 1;
