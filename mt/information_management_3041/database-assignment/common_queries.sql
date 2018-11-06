-- Trigger to process a match win
DELIMITER $$
CREATE TRIGGER process_fixture_win
    AFTER UPDATE ON Fixtures
    FOR EACH ROW
BEGIN
    IF NEW.result = "win" THEN
		    UPDATE Teams
			SET points = points + 3
			WHERE id = NEW.winner_id;
	END IF;
END$$
DELIMITER ;

-- Query to test trigger
UPDATE Fixtures
SET result="win", winner_id=1
WHERE id=1

-- Query to test trigger
INSERT INTO Transfers (id, player_id, old_team_id, new_team_id, transfer_fee, date)
VALUES (2, 1, 2, 1, 5000000, "2018-11-6");
