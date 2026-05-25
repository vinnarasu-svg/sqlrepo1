#create schema

create schema cricket_tornament;
use cricket_tornament ;

#create table

create table teams(
                   team_id int primary key,
                   team_name varchar(50) not null,
                   caption varchar(20) not null
);

describe teams;

drop table players;
create table players(
                     player_id int primary key,
                     player_name varchar(20) not null,
                     team_id int not null,
                     role varchar(20) ,
                     runs int,
                     wickets int,
                     foreign key (team_id) references teams (team_id)
);
describe players;

create table matches(
                     match_id int primary key,
                     team1_id int not null,
                     team2_id int not null,
                     winner_team_id int,
                     match_date date not null,
                     stadium varchar(20) not null
);
describe matches;


drop table schore;
create table score(
					score_id int primary key,
                    match_id int,
                    player_id int not null,
                    runs_scored int,
                    balls_faced int,
                    wickets_taken int,
                    foreign key (match_id) references matches (match_id),
                    foreign key (player_id) references players (player_id)
);
describe score;

#change column name
alter table teams rename column caption  to captain;

#insert values in table

INSERT INTO teams (team_id, team_name, captain)
VALUES
(1, 'CSK', 'Dhoni'),
(2, 'MI', 'Hardik'),
(3, 'RCB', 'Kohli'),
(4, 'KKR', 'Rahane'),
(5, 'SRH', 'Cummins');

INSERT INTO players (player_id, player_name, team_id, role, runs, wickets)
VALUES
(101, 'Dhoni', 1, 'Batsman', 3500, 0),
(102, 'Jadeja', 1, 'All-Rounder', 2500, 120),
(103, 'Gaikwad', 1, 'Batsman', 2800, 0),
(104, 'Rohit', 2, 'Batsman', 5000, 0),
(105, 'Bumrah', 2, 'Bowler', 200, 150),
(106, 'Surya', 2, 'Batsman', 3200, 10),
(107, 'Kohli', 3, 'Batsman', 7000, 5),
(108, 'Maxwell', 3, 'All-Rounder', 2900, 35),
(109, 'Russell', 4, 'All-Rounder', 2400, 80),
(110, 'Head', 5, 'Batsman', 1800, 2);

INSERT INTO matches (match_id, team1_id, team2_id, winner_team_id, match_date, stadium)
VALUES
(1001, 1, 2, 1, '2026-05-01', 'Chepauk'),
(1002, 2, 3, 3, '2026-05-03', 'Wankhede'),
(1003, 1, 3, 3, '2026-05-05', 'Chinnaswamy'),
(1004, 4, 5, 4, '2026-05-06', 'Eden Gardens'),
(1005, 2, 5, 2, '2026-05-07', 'Hyderabad'),
(1006, 1, 4, 1, '2026-05-08', 'Chepauk'),
(1007, 3, 5, 3, '2026-05-09', 'Chinnaswamy'),
(1008, 2, 4, 4, '2026-05-10', 'Wankhede'),
(1009, 1, 5, 5, '2026-05-11', 'Hyderabad'),
(1010, 3, 4, 3, '2026-05-12', 'Eden Gardens');

INSERT INTO score (score_id, match_id, player_id, runs_scored, balls_faced, wickets_taken)
VALUES
(1, 1001, 101, 45, 30, 0),
(2, 1001, 102, 32, 20, 2),
(3, 1002, 107, 88, 50, 0),
(4, 1002, 105, 10, 8, 3),
(5, 1003, 103, 70, 45, 0),
(6, 1004, 109, 55, 25, 2),
(7, 1005, 104, 90, 55, 0),
(8, 1006, 102, 40, 22, 3),
(9, 1007, 110, 76, 48, 0),
(10, 1010, 108, 60, 35, 1);

#aggregation

 #questions
-- 1. Total number of matches find pannunga
#count
select count(match_id) as total_matches from matches ;

-- 2. Total runs in tournament find pannunga
#sum
select sum(runs_scored) as total_runs from score;

-- 3. Average runs scored in all matches find pannunga
#avg
select avg(runs_scored) as avg_runs from score;

-- 4. Highest individual score find pannunga
#max
select max(runs_scored) as high_score from score;

-- 5. Lowest individual score find pannunga
#min
select min(runs_scored) as low_score from score;

-- 6. Each player oda total runs calculate pannunga
select player_id,
sum(runs_scored) as total_score
from score
GROUP BY PLAYER_ID; 

-- 8. Which team has maximum players nu find pannunga
SELECT 
    team_id,
    COUNT(*) AS player_count
FROM players
GROUP BY team_id
ORDER BY player_count DESC
LIMIT 1;
-- 9. Stadium-wise total matches count pannunga
SELECT stadium,
count(match_id) as total_mathes
from matches
group by stadium;

-- 10. 50 runs-ku mela total score pannina players find pannunga


-- 11. Top scorer list descending order la display pannunga

-- 12. Top 3 highest scores display pannunga

-- 13. Different player roles mattum display pannunga

-- 14. Team-wise average runs calculate pannunga

-- 15. Match-wise total score calculate pannunga

-- 16. Highest wicket taker find pannunga

-- 17. More than 1 match win pannina teams find pannunga

-- 18. Player-wise match count find pannunga

-- 19. Team with highest total runs find pannunga

-- 20. Average wickets taken by bowlers find pannunga


                   
                   
			