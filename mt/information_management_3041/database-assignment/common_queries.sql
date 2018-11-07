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
CREATE TRIGGER process_fixture_goal_difference AFTER UPDATE ON Fixtures
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
CREATE TRIGGER process_player_transfer AFTER INSERT ON Transfers
    FOR EACH ROW
BEGIN
    UPDATE Players
    SET team_id = NEW.new_team_id,
			changed_at = NOW()
	WHERE id = NEW.player_id;
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
