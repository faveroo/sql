CREATE TABLE teams (
    id integer PRIMARY KEY,
    name varchar(50)
);


CREATE TABLE matches  (
    id integer PRIMARY KEY,
    team_1 integer,
    team_2 integer,
    team_1_goals integer,
    team_2_goals integer,
    FOREIGN KEY (team_1) REFERENCES teams(id),
    FOREIGN KEY (team_2) REFERENCES teams(id)
);

insert into teams
    (id, name)
values
    (1,'CEARA'),
    (2,'FORTALEZA'),
    (3,'GUARANY DE SOBRAL'),
    (4,'FLORESTA');

insert into  matches
    (id, team_1, team_2, team_1_goals, team_2_goals)
values
    (1,4,1,0,4),
    (2,3,2,0,1),
    (3,1,3,3,0),
    (4,3,4,0,1),
    (5,1,2,0,0),
    (6,2,4,2,1);

SELECT t.name, 
       count(m.id) as matches,
       SUM(CASE 
        WHEN (t.id = m.team_1 AND m.team_1_goals > m.team_2_goals) OR 
        (t.id = m.team_2 AND m.team_2_goals > m.team_1_goals) 
        THEN 1 ELSE 0 END) as victories,
        
       SUM(CASE 
        WHEN (t.id = m.team_1 AND m.team_1_goals < m.team_2_goals) OR 
             (t.id = m.team_2 AND m.team_2_goals < m.team_1_goals) 
        THEN 1 ELSE 0 END) AS defeats,
        
      SUM(CASE 
        WHEN (t.id = m.team_1 AND m.team_1_goals = m.team_2_goals) OR 
             (t.id = m.team_2 AND m.team_2_goals = m.team_1_goals) 
        THEN 1 ELSE 0 END) AS draws,
        
    (3 * SUM(CASE 
        WHEN (t.id = m.team_1 AND m.team_1_goals > m.team_2_goals) OR 
             (t.id = m.team_2 AND m.team_2_goals > m.team_1_goals) 
        THEN 1 ELSE 0 END) + 
        SUM(CASE 
        WHEN (t.id = m.team_1 AND m.team_1_goals = m.team_2_goals) OR 
            (t.id = m.team_2 AND m.team_2_goals = m.team_1_goals) 
        THEN 1 ELSE 0 END)) AS score 
       
FROM teams t
LEFT JOIN matches m
ON t.id=m.team_1 OR t.id=m.team_2
GROUP BY 
t.id, t.name
ORDER BY
  score DESC;
