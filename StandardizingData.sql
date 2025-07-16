-- Task 1: Trim whitespace around company names
update layoffs_staging2
set company = TRIM(company);

-- Task 2: Show all rows where industry starts with 'Crypto'
select * from layoffs_staging2
where industry like 'Crypto%'
order by 1;

-- Task 3: Standardize industry values beginning with 'Crypto'
update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

-- Task 4: List all distinct locations
select distinct location from layoffs_staging2
order by 1;

-- Task 5: Normalize country entries to 'United States'
update layoffs_staging2
set country = 'United States'
where country like 'United States%';

-- Task 6: List all distinct countries
select distinct country from layoffs_staging2
order by 1;

-- Task 7: Parse original date strings into MySQL date format
select `date`,
  STR_TO_DATE(`date`,'%m/%d/%y')
from layoffs_staging2;

-- Task 8: Update the date column to proper DATE values
update layoffs_staging2
set `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

-- Task 9: Verify all data after date conversion
select * from layoffs_staging2;

-- Task 10: Change the column type of `date` to DATE
alter table layoffs_staging2
modify `date` date;

-- Task 11: Identify rows missing both total and percentage layoffs
select * from layoffs_staging2
where total_laid_off is null
  and percentage_laid_off is null;

-- Task 12: Identify rows with missing or empty industry
select * from layoffs_staging2
where industry is null
  or industry = '';

-- Task 13: Isolate data for companies with missing data and repopulate it with correct info
select * from layoffs_staging2
where company = "Bally's Interactive";

update layoffs_staging2
set industry = 'Transportation'
where company = 'Carvana';

-- Task 14: Remove rows missing both total and percentage layoffs
delete from layoffs_staging2
where total_laid_off is null
  and percentage_laid_off is null;
