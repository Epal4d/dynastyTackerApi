-- seed_data.sql
-- Sample data for the dynasty tracker.
-- Inserted in dependency order: parents before children, so every
-- foreign key points at a row that already exists.

-- 1. Seasons (parent of player_season)
INSERT INTO season (year) VALUES (2027);   -- gets id 1
INSERT INTO season (year) VALUES (2028);   -- gets id 2
INSERT INTO season (year) VALUES (2029);   -- gets id 3

-- 2. User (parent of team)
INSERT INTO user (system_type) VALUES ('PS5');   -- gets id 1

-- 3. Team (needs a user_id; user above is id 1)
INSERT INTO team (name, user_id, offensive_playbook, defensive_playbook, overall, offensive_rating, defensive_rating)
VALUES ('Tennessee', 1, 'Air Raid', '4-2-5', 88, 90, 85);   -- gets id 1

-- 4. Players (each needs a team_id; team above is id 1)
INSERT INTO player (team_id, name, recruited_position, recruiting_status, star_rating, interest_level, pipeline, committed_date)
VALUES (1, 'Marcus Reed', 'S', 'signed', 4, 100, 3, '2026-12-20');   -- gets id 1

INSERT INTO player (team_id, name, recruited_position, recruiting_status, star_rating, interest_level, pipeline, committed_date)
VALUES (1, 'Devon Hayes', 'QB', 'signed', 5, 100, 1, '2026-12-20');  -- gets id 2

-- A recruit not yet signed: nullable recruiting fields left mostly empty on purpose
INSERT INTO player (team_id, name, recruited_position, recruiting_status, star_rating, interest_level, pipeline, committed_date)
VALUES (1, 'Isaiah Cole', 'WR', 'committed', 4, 75, 2, NULL);        -- gets id 3

-- 5. player_season rows: the connecting rows the join will read.
--    Marcus Reed (player 1) plays THREE seasons and CHANGES POSITION:
--    recruited as a Safety, moves to Linebacker by his junior year.
--    This is the exact history the app is built to track.
INSERT INTO player_season (player_id, season_id, class_year, position, nil, overall)
VALUES (1, 1, 'FR', 'S',  5000,  74);   -- 2027, freshman, still at safety

INSERT INTO player_season (player_id, season_id, class_year, position, nil, overall)
VALUES (1, 2, 'SO', 'S',  12000, 79);   -- 2028, sophomore, still safety

INSERT INTO player_season (player_id, season_id, class_year, position, nil, overall)
VALUES (1, 3, 'JR', 'LB', 30000, 86);   -- 2029, junior, MOVED to linebacker

-- Devon Hayes (player 2): two seasons at QB, no position change
INSERT INTO player_season (player_id, season_id, class_year, position, nil, overall)
VALUES (2, 1, 'FR', 'QB', 40000, 82);
INSERT INTO player_season (player_id, season_id, class_year, position, nil, overall)
VALUES (2, 2, 'SO', 'QB', 75000, 88);

-- Isaiah Cole (player 3) is still a recruit, so he has NO player_season rows yet.
-- He isn't on any roster. This matters for the join later.

-- 6. A note on Marcus Reed: the position-change PLAN that became real
INSERT INTO player_notes (player_id, notes, created_at, type, target_position, target_year)
VALUES (1, 'Frame and closing speed project better at LB long-term. Move by year 3.', '2027-01-15', 'plan', 'LB', 2029);