Select *
From athlete_events;

Select * 
From noc_regions;




-- How many olympics games have been held?



Select count(distinct (Games)) [Count of all Olympic games]
From athlete_events;




-- List down all Olympics games held so far.



Select Distinct(Year), Season, City
From athlete_events
Order by Year;




-- Mention the total no of nations who participated in each olympics game?



Select Games, count(distinct(region)) as [Total Countries]
From athlete_events

join noc_regions on athlete_events.NOC = noc_regions.NOC
Group by Games
Order by Games;




-- Identify the sport which was played in all summer olympics.



With t1 as (Select count(distinct(Games)) as [Total Summer Olympic Games]
From athlete_events
Where Season = 'Summer'), 

t2 as (Select distinct(Sport), Games
From athlete_events
Where Season = 'Summer'
),

t3 as (Select Sport, COUNT(Games) as [Number of Games]
From t2
group by sport)

Select *
From t3
join t1 on t1.[Total Summer Olympic Games] = t3.[Number of Games]




-- Fetch details of the oldest athletes to win a gold medal.



Select Top 2 Name, Sex, Age, Team, Games, City, Sport, Event, Medal
From athlete_events
Where Medal = 'Gold'
Order by Age desc;




-- In which Sport/event, India has won highest medals.



Select top 1 Sport, COUNT(Medal) as [Total Medal]
From athlete_events

join noc_regions on
athlete_events.NOC = noc_regions.NOC

Where Medal <> 'NA' and region = 'India'
Group by Sport
Order by [Total Medal] desc;




-- Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.



Select Team, Sport, Games, COUNT(Medal) as [Total Medal]
From athlete_events

join noc_regions on
athlete_events.NOC = noc_regions.NOC

Where Medal <> 'NA' and region = 'India'
Group by Team, Sport, Games
Order by [Total Medal] desc;




-- Fetch the top 5 athletes who have won the most gold medals.



With CTE_1 as (Select Name, COUNT(1) as [Total Medals]
From athlete_events
Where Medal = 'Gold'
Group by Name),

CTE_2 as (Select *, DENSE_RANK() over(order by [Total Medals] desc) as Rnk
		  From CTE_1)

Select *
From CTE_2
Where Rnk <= 5;






