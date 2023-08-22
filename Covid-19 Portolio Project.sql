SELECT * FROM CovidDeaths
WHERE continent is NOT NULL
Order by 3,4;

DELETE FROM CovidDeaths
WHERE location = 'High income';

DELETE FROM CovidDeaths
WHERE location IN ('Lower middle income', 'Upper middle income','Low income');

SELECT * FROM CovidVacination
ORDER BY 3,4 ;

SELECT location, date, total_cases, new_cases,total_deaths, population
FROM CovidDeaths
ORDER BY 1,2;

-- Total cases vs Total Deaths
--COVID-19 Mortality Analysis in Nigeria Over Time: Examining Total Cases, Total Deaths, and Mortality Rate
SELECT location, date, total_cases, total_deaths, 
(CAST(total_deaths as float)/CAST(total_cases as float))*100 as Mortality_Rate
FROM CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2;

--Total Cases vs Population 
-- COVID-19 Infection Rate In Nigeria Over Time: Examing Total Cases, Population, and Infection Rate
SELECT location, date, population, total_cases,  
(CAST(total_cases as float)/CAST(population as float))*100 as Infection_Rate
FROM CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2;

--Countries with Highest Infection Rate compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount,  
MAX((CAST(total_cases as float)/CAST(population as float)))*100 as Infection_Rate_Per_Population
FROM CovidDeaths
GROUP BY location, population
ORDER BY Infection_Rate_Per_Population DESC;

--Countries with Highest Death Count
SELECT location, MAX(total_deaths) as Max_Death_Count
FROM CovidDeaths
GROUP BY location 
ORDER BY Max_Death_Count DESC;
--OR
SELECT location, MAX(total_deaths) as Max_Death_Count
FROM CovidDeaths
WHERE continent is  NULL
GROUP BY location
ORDER BY Max_Death_Count DESC;

--Continent with Highest Death Count
SELECT continent, MAX(total_deaths) as Max_Death_Count
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY Max_Death_Count DESC;

--Global Numbers 
SELECT date,SUM(new_cases) AS Total_New_Cases_per_date,
 SUM(new_deaths) AS Total_New_Deaths_per_date,
(SUM(new_deaths) * 100.0) / NULLIF(SUM(new_cases), 0) AS Mortality_Rate
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

--Total Populayion vs Vaccination
SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location
ORDER BY dea.location,dea.date) AS ROLLING_COUNT
FROM CovidDeaths dea
JOIN CovidVacination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

-- USE CTE
WITH PopvsVac (Continent, Location, Date, Population, new_vaccinations,RollingPeopleVaccinated)
as
(
SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location
ORDER BY dea.location,dea.date) AS ROLLING_COUNT
FROM CovidDeaths dea
JOIN CovidVacination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3
)
SELECT *,(RollingPeopleVaccinated/Population)*100 as VacinationRate
FROM PopvsVac

--TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date Datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location
ORDER BY dea.location,dea.date) AS ROLLING_COUNT
FROM CovidDeaths dea
JOIN CovidVacination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

SELECT *,(RollingPeopleVaccinated/Population)*100 as VacinationRate
FROM #PercentPopulationVaccinated


--Creating View to store data for Visualization
-- Percentage of People Vaccinated
Create view PercentPopulationVaccinated as 
SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (Partition by dea.location
ORDER BY dea.location,dea.date) AS ROLLING_COUNT
FROM CovidDeaths dea
JOIN CovidVacination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null

--Continent with Highest Death Count
CREATE VIEW Continent_with_Highest_Death_Count as
SELECT continent, MAX(total_deaths) as Max_Death_Count
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY continent

--Countries with Highest Death Count
CREATE VIEW Countries_with_Highest_Death_Count AS
SELECT location, MAX(total_deaths) as Max_Death_Count
FROM CovidDeaths
GROUP BY location;

--Countries with Highest Infection Rate compared to population
CREATE VIEW Countries_Infection_Rate_Per_Population as
SELECT location, population, MAX(total_cases) AS HighestInfectionCount,  
MAX((CAST(total_cases as float)/CAST(population as float)))*100 as Infection_Rate_Per_Population
FROM CovidDeaths
GROUP BY location, population
