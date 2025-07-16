-- Task 1: Get the maximum total and percentage of layoffs
select max(total_laid_off), max(percentage_laid_off) 
from layoffs_staging2;

-- Task 2: Retrieve the record with the highest percentage laid off
select * 
from layoffs_staging2
order by percentage_laid_off desc
limit 1;

-- Task 3: Among those with 100% layoffs, find the company with the highest total laid off
select * 
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

-- Task 4: Sum total layoffs by company, ordered by most fired
select company, sum(total_laid_off) as total_fired
from layoffs_staging2
group by company
order by sum(total_laid_off) desc;

-- Task 5: Find the date range of the dataset
select min(`date`) as beginning, max(`date`) as ending
from layoffs_staging2;

-- Task 6: Sum total layoffs by industry, ordered by most fired
select industry, sum(total_laid_off) as total_fired
from layoffs_staging2
group by industry
order by sum(total_laid_off) desc;

-- Task 7: Sum total layoffs by country, ordered by most fired
select country, sum(total_laid_off) as total_fired
from layoffs_staging2
group by country
order by sum(total_laid_off) desc;

-- Task 8: Sum total layoffs by year, ordered by most fired
select year(`date`) , sum(total_laid_off) as total_fired
from layoffs_staging2
group by year(`date`)
order by sum(total_laid_off) desc;

-- Task 9: Sum total layoffs by month (YYYY-MM), ordered chronologically
select substring(`date`, 1 ,7) as month, sum(total_laid_off) 
from layoffs_staging2
where substring(`date`, 1 ,7) is not Null
group by substring(`date`, 1 ,7)
order by 1 asc;

-- Task 10: Compute cumulative monthly layoffs over time
with rolling_total as 
(
  select substring(`date`, 1 ,7) as month, sum(total_laid_off) as total_off 
  from layoffs_staging2
  where substring(`date`, 1 ,7) is not Null
  group by substring(`date`, 1 ,7)
  order by 1 asc
)
select `month`, sum(total_off) over(order by `month`)
from rolling_total;

-- Task 11: Yearly total layoffs per company, ordered by company name
select year(`date`) , company, sum(total_laid_off) as total_fired
from layoffs_staging2
group by year(`date`), company
order by company;

-- Task 12: Yearly total layoffs per company, ordered by amount desc
select year(`date`) , company, sum(total_laid_off) as total_fired
from layoffs_staging2
group by year(`date`), company
order by 3 desc;

-- Task 13: Top 5 companies with highest layoffs each year
with company_year as 
(
  select year(`date`) as years, company, sum(total_laid_off) as total_fired
  from layoffs_staging2
  group by year(`date`), company
),
company_year_rank as
(
  select *, dense_rank() over(partition by years order by total_fired desc) as ranking
  from company_year
  where years is not null
  order by ranking
)
select * 
from company_year_rank
where ranking <= 5;
