-- Khaled Osama 221902213
-- I have created Simple and a innovative project with my limited knowledge.
-- Welcome to Players Leaderboard!!!

create database PLB;
use PLB;

-- this is the players info table
create table Players(
    player_id int primary key auto_increment,
    player_name varchar(100) not null,
    player_email varchar(100) unique,
    join_date DATE not null);

-- this is a games table
create table Games(
    game_id int primary key auto_increment,
    game_name varchar(100) not null,
    release_date DATE NOT NULL);

-- this is a players ranking table
create table Rankings(
    ranking_id int primary key auto_increment,
    player_id INT,
    game_id INT,
    ranking_position INT,
    last_updated TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp,
    foreign key (player_id) references Players(player_id),
    foreign key (game_id) references Games(game_id));

-- this is a clans table
create table Clans(
    clan_id int primary key auto_increment,
    clan_name varchar(100) not null,
    clan_leader INT,
    creation_date DATE NOT NULL,
    foreign key (clan_leader) references Players(player_id));
    
-- this is my stats table
create table Stats(
    stats_id int primary key auto_increment,
    player_id INT,
    game_id INT,
    wins INT DEFAULT 0,
    losses INT DEFAULT 0,
    total_matches INT DEFAULT 0,
    foreign key (player_id) references Players(player_id),
    foreign key (game_id) references Games(game_id));

-- here i created a trigger where its update players stats after match result is inserted!
-- trigger "update_stats_after_match" demonstrates a feature to automate the update of player stats after a match result is inserted.
DELIMITER $$
create trigger update_stats_after_match
after insert on Rankings
for each row
BEGIN
    IF NEW.ranking_position = 1 then
        UPDATE Stats
        SET wins = wins + 1,
            total_matches = total_matches + 1
        WHERE player_id = NEW.player_id and game_id = NEW.game_id;
    ELSE
        UPDATE Stats
        SET losses = losses + 1,
            total_matches = total_matches + 1
        WHERE player_id = NEW.player_id and game_id = NEW.game_id;
    END IF;
END;
$$
DELIMITER ;

-- here i added some values from ESL website
INSERT INTO Players (player_name, player_email, join_date)
VALUES ('Shroud', 'shrood@esports.com', '2007-01-01'),
	   ('DrRespect', 'respect@esports.com', '2004-03-11'),
       ('DeaGer', 'deager@esports.com', '2010-04-19'),
       ('NinJa', 'ninjalingus@esports.com', '2009-02-01');
INSERT INTO Games (game_name, release_date)
VALUES ('Counter-Strike: Global Offensive', '2012-08-21'),
       ('Dota 2', '2013-07-09'),
       ('Naraka Bladepoint', '2021-08-21');
INSERT INTO Rankings (player_id, game_id, ranking_position)
VALUES (1, 1, 10),
       (1, 2, 5),
       (2, 1, 1),
       (2, 2, 11),
       (3, 1, 1),
       (3, 3, 2),
       (4, 3, 1),
       (4, 2, 4);
INSERT INTO Clans (clan_name, clan_leader, creation_date)
VALUES ('Team NaVi', 1, '2016-02-15'),
       ('Team FaZe Clan', 2, '2017-03-20');
INSERT INTO Stats (player_id, game_id, wins, losses, total_matches)
VALUES (1, 1, 300, 80, 380),
	   (1, 2, 220, 80, 300),
       (2, 3, 2200, 300, 2500),
       (2, 1, 420, 80, 500),
       (3, 1, 700, 250, 950),
       (3, 3, 2700, 250, 2950),
       (4, 2, 200, 35, 235);

-- Here's the 10 features or query for my project
-- For registering a new player:
insert into Players (player_name, player_email, join_date)
values ('Sindar', 'sinder@gmail.com', '2024-01-01');

-- For Adding a new game
insert into Games (game_name, release_date)
values ('Call of Duty: Warzone', '2020-03-10');

-- For Altering game release date:
update Games
set release_date = '2024-01-01'
WHERE game_id = 4;

-- For Recording player rankings:
insert into Rankings (player_id, game_id, ranking_position)
values (5, 4, 1);

-- Creating a clan/team:
insert into Clans (clan_name, clan_leader, creation_date)
values ('Team Alpha', 5, '20224-01-01');

-- Deleting a players and clan:
delete from Clans
WHERE clan_id = 5;
delete from Players
WHERE player_id = 6;

-- Recording player stats for a game:
insert into Stats (player_id, game_id, wins, losses, total_matches)
values (5, 4, 1400, 250, 1650);

-- Updating player's email:
UPDATE Players
set player_email = 'sindar2@mail.com'
WHERE player_id = 5;

-- Retrieving player rankings for a game:
select player_name, ranking_position
from Players
INNER JOIN Rankings on Players.player_id = Rankings.player_id
WHERE game_id = 1
order by ranking_position;

-- Retrieving clan/team information:
select *
from Clans
WHERE clan_id = 1;

-- Calculating win percentage for a player:
select (wins / total_matches) * 100 as win_percentage
from Stats
WHERE player_id = 1 and game_id = 1;
