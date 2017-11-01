INSERT INTO ultical.SEASON (season_year, surface) VALUES (YEAR( CURDATE() ), 'TURF'), (YEAR( CURDATE() ) + 1, 'GYM');
INSERT INTO ultical.CONTACT (email,name,phone) VALUES ('test@ultical.com', 'Test Kontakt', '+49 123 45678');
INSERT INTO ultical.ASSOCIATION (id,name,contact,acronym) VALUES (1,'Test Verband',1,'TV');
INSERT INTO ultical.TOURNAMENT_FORMAT (name,description,association) VALUES ('Test Format', 'A TournamentFormat is the most abstract possiblity for grouping events and editions', 1);
INSERT INTO ultical.TOURNAMENT_EDITION (tournament_format,registration_start, registration_end, season, organizer) VALUES (1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 MONTH), 1, 1);
