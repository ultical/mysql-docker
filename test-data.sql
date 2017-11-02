INSERT INTO ultical.SEASON (season_year, surface) VALUES (YEAR( CURDATE() ), 'TURF'), (YEAR( CURDATE() ) + 1, 'GYM');
INSERT INTO ultical.CONTACT (email,name,phone) VALUES ('test@ultical.com', 'Test Kontakt', '+49 123 45678');
INSERT INTO ultical.ASSOCIATION (id,name,contact,acronym) VALUES (1,'Test Verband',1,'TV');
-- create tournamen format
INSERT INTO ultical.TOURNAMENT_FORMAT (name,description,association) VALUES ('Test Format', 'A TournamentFormat is the most abstract possiblity for grouping events and editions', 1);
-- create tournament edition
INSERT INTO ultical.TOURNAMENT_EDITION (tournament_format,registration_start, registration_end, season, organizer) VALUES (1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 MONTH), 1, 1);
INSERT INTO ultical.DIVISION_REGISTRATION (tournament_edition, division_type, division_age, number_of_spots, division_identifier) VALUES (1, 'OPEN', 'MASTERS', 8, 'Open Masters Test'), (1,'WOMEN','REGULAR',12,'Damen Test');
-- create event
INSERT INTO ultical.EVENT (tournament_edition, start_date, end_date, local_organizer, info, name) VALUES (1, DATE_ADD( DATE_ADD( CURDATE() , INTERVAL 1 MONTH ), INTERVAL 7 DAY), DATE_ADD( DATE_ADD( CURDATE(), INTERVAL 1 MONTH ), INTERVAL 8 DAY ), 1, 'the concrete event of this years edition. There can be more than one event for a tournament edition', 'Test Event');
INSERT INTO ultical.DIVISION_CONFIRMATION (division_registration, event) VALUES (1,1), (2,1);
-- create a club
INSERT INTO ultical.CLUB (id, name, association) VALUES (1, 'Testimate e.V.', 1);
-- create a team
INSERT INTO ultical.TEAM (description, founding_date, name, club) VALUES ('Ultimate for testing', YEAR( CURDATE() ), 'Testimate', 1);
-- create different users
INSERT INTO ultical.ULTICAL_USER ( email, password, email_confirmed, dfv_email_opt_in) VALUES ( 'team@admin.com', 'INVALID', 1, 1 ), ( 'event@admin.com', 'INVALID', 1, 1), ('format@admin.com', 'INVALID', 1, 1), ('assoc@admin.com', 'INVALID', 1, 1);
INSERT INTO ultical.TEAM_ULTICAL_USERS (team, admin) VALUES (1,1);
INSERT INTO ultical.EVENT_ULTICAL_USERS (event, admin) VALUES (1, 2);
INSERT INTO ultical.TOURNAMENT_FORMAT_ULTICAL_USERS (tournament_format, admin) VALUES (1, 3);
INSERT INTO ultical.ASSOCIATION_ULTICAL_USERS (association, admin) VALUES (1,4);
