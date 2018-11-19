-- Trigger to process a match win
DELIMITER $$
CREATE TRIGGER process_fixture_win AFTER UPDATE ON Fixtures
    FOR EACH ROW
BEGIN
    IF NEW.result = 'win' THEN
		    UPDATE Teams
			SET points = points + 3
			WHERE id = NEW.winner_id;
	END IF;
END$$
DELIMITER ;

-- Query to test trigger
UPDATE Fixtures
SET result='win', winner_id=1
WHERE id=1

------------------------------------------------------------------------
------------------------------------------------------------------------

-- Trigger to process goal difference
DELIMITER $$
CREATE TRIGGER process_fixture_goal_difference AFTER UPDATE ON Result
    FOR EACH ROW
BEGIN
    IF NEW.result = 'win' THEN
  		-- If the home team won update goal difference accordingly
  		IF NEW.winner_id = NEW.home_team_id THEN
  			UPDATE Teams
  			SET goal_difference = CASE
  				WHEN id = NEW.home_team_id THEN goal_difference + (NEW.home_goals - NEW.away_goals)
          WHEN id = NEW.away_team_id THEN goal_difference - (NEW.home_goals - NEW.away_goals)
          ELSE goal_difference + 0
        END;
  		-- If the away team won update goal difference accordingly
  		ELSEIF NEW.winner_id = NEW.away_team_id THEN
  			UPDATE Teams
  			SET goal_difference = CASE
  				WHEN id = NEW.home_team_id THEN goal_difference - (NEW.away_goals - NEW.home_goals)
          WHEN id = NEW.away_team_id THEN goal_difference + (NEW.away_goals - NEW.home_goals)
          ELSE goal_difference + 0
        END;
  		END IF;
	  END IF;
END$$
DELIMITER ;

-- Query to test trigger
UPDATE Fixtures
SET home_goals=5, away_goals=2
WHERE id=1

------------------------------------------------------------------------
------------------------------------------------------------------------

-- Trigger to update player_team_id
DELIMITER $$
CREATE TRIGGER process_player_transfer AFTER INSERT ON Transfer
    FOR EACH ROW
BEGIN
    UPDATE Players
    SET team_id = NEW.new_team_id
	WHERE player_id = NEW.player_id;
END$$
DELIMITER ;

-- Query to test trigger
INSERT INTO `premier-league`.Transfers (id, player_id, old_team_id, new_team_id, transfer_fee, date)
VALUES (3, 1, 1, 2, 5000000, '2018-11-06');

------------------------------------------------------------------------
------------------------------------------------------------------------

-- Trigger to update manager_id for team
DELIMITER $$
CREATE TRIGGER process_new_manager AFTER INSERT ON Managers
    FOR EACH ROW
BEGIN
  -- Update manager id in Teams
	UPDATE Teams
    SET manager_id = NEW.id
    WHERE id = NEW.team_id;
END$$
DELIMITER ;

-- Query to test trigger
INSERT INTO `premier-league`.Managers
VALUES (11, 'Brandon', 'Dooley', 21, 97000000, Ireland, 1);


------------------------------------------------------------------------
------------------------------------------------------------------------

-- Trigger to set manager_id to null for team
DELIMITER $$
CREATE TRIGGER process_manager_delete BEFORE DELETE ON Managers
    FOR EACH ROW
BEGIN
  -- Update manager id in Teams
	UPDATE Teams
    SET manager_id = NULL
    WHERE id = OLD.team_id;
END$$
DELIMITER ;

-- Query to test trigger
DELETE FROM Managers WHERE id = 11;

------------------------------------------------------------------------
------------------------------------------------------------------------

-- View for teams summary
CREATE VIEW `teams_overview` AS
SELECT t.team_name, m.manager_name, s.stadium_name, t.position, t.points
FROM Team t, Manager m, Stadium s
WHERE t.team_id=m.team_id
AND t.team_id=s.team_id;

-- Run view
SELECT * FROM `premier-league`.teams_overview;

------------------------------------------------------------------------
------------------------------------------------------------------------

-- View for managers summary
CREATE VIEW `managers_overview` AS
SELECT m.manager_name, t.team_name
FROM Team t, Manager m
WHERE t.team_id=m.team_id

-- Run view
SELECT * FROM `premier-league`.teams_overview;

------------------------------------------------------------------------
------------------------------------------------------------------------

-- View for players usmmary
CREATE VIEW `players_overview` AS
SELECT concat(p.first_name, ' ', p.second_name) as player_name, t.team_name, p.position, p.country, p.number
FROM Player p, Team t
WHERE p.team_id=t.team_id;

-- Run view
SELECT * FROM `premier-league`.players_overview;
