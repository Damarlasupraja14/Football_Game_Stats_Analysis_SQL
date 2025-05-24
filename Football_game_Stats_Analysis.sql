use logistics;
select * from `sql test data - teamgame`;
select count(DISTINCT Team) as no_of_teams 
from `sql test data - teamgame` 
where Season=2008 and PlayingSurface="Artificial";

-- Write a query to display top 3 teams that had the highest Home game Opponent Score (totalled from all Home games put together).
Select Team, SUM(OpponentScore) as TotalOpponentScore
FROM `sql test data - teamgame`
WHERE HomeOrAway="Home"
group by Team
order by TotalOpponentScore DESC
LIMIT 3;

select * from `sql test data - fantasydefensegame`;
SELECT "PointsAllowed" as Value, SUM(PointsAllowed) as Total from `sql test data - fantasydefensegame`
UNION ALL 
SELECT "SoloTackles", SUM(SoloTackles)  FROM `sql test data - fantasydefensegame`
UNION ALL
SELECT "Sacks", SUM(Sacks) FROM `sql test data - fantasydefensegame`;

SELECT 'PointsAllowed' AS Value, SUM(COALESCE(PointsAllowed,0)) AS Total
FROM `sql test data - fantasydefensegame`;


select * from `sql test data - playergamemaster`;
select * from `sql test data - playergamescores`;

CREATE  Temporary TABLE Player  AS
SELECT  PlayerID,Name,Team, Opponent, Position
FROM `sql test data - playergamemaster`
WHERE Season = 2014;

CREATE  Temporary TABLE Scores  AS
SELECT  PlayerID,Name,Team, Opponent, Position, PassingAttempts
FROM `sql test data - playergamescores`
WHERE Season = 2014;

#Join them
SELECT p.PlayerID, p.Name, p.Team, p.Opponent, p.Position
FROM Player P
LEFT JOIN Scores s on   p.PlayerID = s.PlayerID
					AND p.Team = s.Team
					AND p.Opponent = s.Opponent
					AND p.Position = s.Position
WHERE  s.PassingAttempts>1;

select * from `sql test data - injury`;
-- Q5. Display top 5 Players (Names) who had the highest number of Questionable Injuries during the Season 2014.
SELECT pgm.Name, COUNT(*) as QuestionableInjuries
FROM `sql test data - injury` as pi
join `sql test data - playergamemaster` as pgm
on pi.PlayerID=pgm.PlayerID
WHERE pi.Season = 2014
      AND pi.Status = "Questionable"
group by pgm.Name
order by QuestionableInjuries DESC
LIMIT 5;
                                  