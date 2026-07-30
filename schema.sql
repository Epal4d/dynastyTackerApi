Create Table season (
id  INTEGER PRIMARY KEY AUTOINCREMENT,
year    INTEGER NOT NULL
);

Create Table user (
    id  INTEGER PRIMARY KEY AUTOINCREMENT,
    system_type VARCHAR NOT NULL
);

Create Table team (
    id  INTEGER PRIMARY KEY AUTOINCREMENT,
    name    VARCHAR NOT NULL,
    user_id INTEGER NOT NULL,
    offensive_playbook VARCHAR NOT NULL,
    defensive_playbook VARCHAR NOT NULL,
    overall INT NOT NULL,
    offensive_rating INT NOT NULL,
    defensive_rating INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

Create Table player (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_id INTEGER,
    name VARCHAR,
    recruited_position VARCHAR,
    recruiting_status VARCHAR,
    star_rating INTEGER,
    interest_level INTEGER,
    pipeline INTEGER,
    committed_date DATE,
    FOREIGN KEY (team_id) REFERENCES team(id)
);

Create Table player_notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    player_id INTEGER,
    notes VARCHAR,
    created_at VARCHAR,
    type VARCHAR,
    target_position VARCHAR,
    target_year INT,
    FOREIGN KEY (player_id) REFERENCES player(id)
);

Create Table player_season (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    player_id INTEGER,
    season_id INTEGER,
    class_year VARCHAR,
    position VARCHAR,
    nil INTEGER,
    overall INTEGER,
    FOREIGN KEY (player_id) REFERENCES player(id),
    FOREIGN KEY (season_id) REFERENCES season(id)
);





