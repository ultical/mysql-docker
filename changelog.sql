--  *********************************************************************
--  Update Database Script
--  *********************************************************************
--  Change Log: db.changelog-1.0.xml
--  Ran at: 11/1/17 4:51 PM
--  Against: ultical@127.0.0.1@jdbc:mysql://localhost:3306/ultical
--  Liquibase version: 3.5.3
--  *********************************************************************

--  Create Database Lock Table
CREATE TABLE ultical.DATABASECHANGELOGLOCK (ID INT NOT NULL, LOCKED BIT(1) NOT NULL, LOCKGRANTED datetime NULL, LOCKEDBY VARCHAR(255) NULL, CONSTRAINT PK_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

--  Initialize Database Lock Table
DELETE FROM ultical.DATABASECHANGELOGLOCK;

INSERT INTO ultical.DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

--  Lock Database
UPDATE ultical.DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = 'bf1ec3cb71cd (172.17.0.2)', LOCKGRANTED = '2017-11-01 16:51:35.133' WHERE ID = 1 AND LOCKED = 0;

--  Create Database Change Log Table
CREATE TABLE ultical.DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, DESCRIPTION VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL, DEPLOYMENT_ID VARCHAR(10) NULL);

--  Changeset db.changelog-1.0.xml::0::basil
CREATE TABLE ultical.PLAYER (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, first_name VARCHAR(64) NOT NULL, last_name VARCHAR(64) NOT NULL, gender VARCHAR(6) DEFAULT 'NA' NOT NULL, is_registered BIT(1) DEFAULT 0 NOT NULL, CONSTRAINT PK_PLAYER PRIMARY KEY (id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('0', 'basil', 'db.changelog-1.0.xml', NOW(), 1, '7:3487701e9ba58520fdbd9771a659d642', 'createTable tableName=PLAYER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::1::basil
CREATE TABLE ultical.LOCATION (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, city VARCHAR(255) NULL, street VARCHAR(255) NULL, zip_code BIGINT NULL, country VARCHAR(255) NULL, country_code VARCHAR(3) NULL, longitude DOUBLE NULL, latitude DOUBLE NULL, additional_info TEXT NULL, CONSTRAINT PK_LOCATION PRIMARY KEY (id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('1', 'basil', 'db.changelog-1.0.xml', NOW(), 2, '7:2ab1cbe4d3375984a1bff84208a40091', 'createTable tableName=LOCATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::2::bas
CREATE TABLE ultical.FEE (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, fee_type VARCHAR(10) NOT NULL, amount VARCHAR(10) NOT NULL, currency VARCHAR(3) NOT NULL, alternative_name VARCHAR(100) NULL, CONSTRAINT PK_FEE PRIMARY KEY (id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('2', 'bas', 'db.changelog-1.0.xml', NOW(), 3, '7:ab241fb416ce9eb0ca6939841edecd9b', 'createTable tableName=FEE', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::3::basil
CREATE TABLE ultical.SEASON (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, surface VARCHAR(10) DEFAULT 'TURF' NOT NULL, season_year SMALLINT NOT NULL, plusOneYear BIT(1) DEFAULT 0 NOT NULL, CONSTRAINT PK_SEASON PRIMARY KEY (id));

ALTER TABLE ultical.SEASON ADD CONSTRAINT uk_season_surface_year UNIQUE (surface, season_year, plusOneYear);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('3', 'basil', 'db.changelog-1.0.xml', NOW(), 4, '7:09756051ce80d2ff391ee46a8ffffd02', 'createTable tableName=SEASON; addUniqueConstraint constraintName=uk_season_surface_year, tableName=SEASON', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::4::basil
CREATE TABLE ultical.DFV_PLAYER (player_id BIGINT NOT NULL, birth_date date NOT NULL, dfv_number VARCHAR(10) NOT NULL);

ALTER TABLE ultical.DFV_PLAYER ADD CONSTRAINT uk_dfv_player_dfv_number UNIQUE (dfv_number);

ALTER TABLE ultical.DFV_PLAYER ADD CONSTRAINT fk_dfv_player_player FOREIGN KEY (player_id) REFERENCES ultical.PLAYER (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('4', 'basil', 'db.changelog-1.0.xml', NOW(), 5, '7:9241e82b488e92f866c78b66b34e7cf3', 'createTable tableName=DFV_PLAYER; addUniqueConstraint constraintName=uk_dfv_player_dfv_number, tableName=DFV_PLAYER; addForeignKeyConstraint baseTableName=DFV_PLAYER, constraintName=fk_dfv_player_player, referencedTableName=PLAYER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::5::basil
CREATE TABLE ultical.ULTICAL_USER (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, email VARCHAR(256) NOT NULL, password VARCHAR(128) NOT NULL, dfv_player BIGINT NULL, email_confirmed BIT(1) DEFAULT 0 NULL, dfv_email_opt_in BIT(1) DEFAULT 0 NULL, CONSTRAINT PK_ULTICAL_USER PRIMARY KEY (id));

ALTER TABLE ultical.ULTICAL_USER ADD CONSTRAINT fk_ultical_user_dfv_player FOREIGN KEY (dfv_player) REFERENCES ultical.PLAYER (id) ON DELETE SET NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('5', 'basil', 'db.changelog-1.0.xml', NOW(), 6, '7:ede105f8798d4958c648a58664b7784a', 'createTable tableName=ULTICAL_USER; addForeignKeyConstraint baseTableName=ULTICAL_USER, constraintName=fk_ultical_user_dfv_player, referencedTableName=PLAYER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::6::basil
CREATE TABLE ultical.UNREGISTERED_PLAYER (player_id BIGINT NOT NULL, email VARCHAR(256) NOT NULL);

ALTER TABLE ultical.UNREGISTERED_PLAYER ADD CONSTRAINT fk_unregistered_player_player FOREIGN KEY (player_id) REFERENCES ultical.PLAYER (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('6', 'basil', 'db.changelog-1.0.xml', NOW(), 7, '7:b7a3017468211eaed47545c25b29c65a', 'createTable tableName=UNREGISTERED_PLAYER; addForeignKeyConstraint baseTableName=UNREGISTERED_PLAYER, constraintName=fk_unregistered_player_player, referencedTableName=PLAYER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::7::bas
CREATE TABLE ultical.CONTACT (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, email VARCHAR(100) NULL, name VARCHAR(100) NULL, phone VARCHAR(50) NULL, CONSTRAINT PK_CONTACT PRIMARY KEY (id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('7', 'bas', 'db.changelog-1.0.xml', NOW(), 8, '7:68b9ad6153b8cd09b1a91b9dd4fe1bf9', 'createTable tableName=CONTACT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::8::basil
CREATE TABLE ultical.TOURNAMENT_FORMAT (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, name VARCHAR(256) NOT NULL, description TEXT NULL, url VARCHAR(255) NULL, CONSTRAINT PK_TOURNAMENT_FORMAT PRIMARY KEY (id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('8', 'basil', 'db.changelog-1.0.xml', NOW(), 9, '7:3db402fe88cc5071dbf056e6b75b05b6', 'createTable tableName=TOURNAMENT_FORMAT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::9::basil
CREATE TABLE ultical.TOURNAMENT_EDITION (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, tournament_format BIGINT NULL COMMENT 'reference to the used tourname_format', alternative_name VARCHAR(256) NULL, registration_start date NOT NULL, registration_end date NOT NULL, season BIGINT NOT NULL COMMENT 'reference to the tournament_edition''s season', hashtag VARCHAR(100) NULL, organizer BIGINT NOT NULL, is_league BIT(1) DEFAULT 0 NOT NULL, CONSTRAINT PK_TOURNAMENT_EDITION PRIMARY KEY (id));

ALTER TABLE ultical.TOURNAMENT_EDITION ADD CONSTRAINT fk_tournament_edition_season FOREIGN KEY (season) REFERENCES ultical.SEASON (id);

ALTER TABLE ultical.TOURNAMENT_EDITION ADD CONSTRAINT fk_tournament_edition_tournament_format FOREIGN KEY (tournament_format) REFERENCES ultical.TOURNAMENT_FORMAT (id) ON DELETE CASCADE;

ALTER TABLE ultical.TOURNAMENT_EDITION ADD CONSTRAINT fk_tournament_edition_contact FOREIGN KEY (organizer) REFERENCES ultical.CONTACT (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('9', 'basil', 'db.changelog-1.0.xml', NOW(), 10, '7:5e508c284246f0f258937e8a4e9485c6', 'createTable tableName=TOURNAMENT_EDITION; addForeignKeyConstraint baseTableName=TOURNAMENT_EDITION, constraintName=fk_tournament_edition_season, referencedTableName=SEASON; addForeignKeyConstraint baseTableName=TOURNAMENT_EDITION, constraintName=f...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::10::basil
CREATE TABLE ultical.TOURNAMENT_FORMAT_ULTICAL_USERS (tournament_format BIGINT NOT NULL, admin BIGINT NOT NULL, CONSTRAINT fk_tournament_format_ultical_users_ultical_users FOREIGN KEY (admin) REFERENCES ultical.ULTICAL_USER(id));

ALTER TABLE ultical.TOURNAMENT_FORMAT_ULTICAL_USERS ADD CONSTRAINT fk_tournament_format_ultical_users_tournament_format FOREIGN KEY (tournament_format) REFERENCES ultical.TOURNAMENT_FORMAT (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('10', 'basil', 'db.changelog-1.0.xml', NOW(), 11, '7:4681c2b65f841424dd280009d2720560', 'createTable tableName=TOURNAMENT_FORMAT_ULTICAL_USERS; addForeignKeyConstraint baseTableName=TOURNAMENT_FORMAT_ULTICAL_USERS, constraintName=fk_tournament_format_ultical_users_tournament_format, referencedTableName=TOURNAMENT_FORMAT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::11::basil
CREATE TABLE ultical.TOURNAMENT_EDITION_LEAGUE (id BIGINT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, alternative_matchday_name VARCHAR(255) NULL, CONSTRAINT PK_TOURNAMENT_EDITION_LEAGUE PRIMARY KEY (id), CONSTRAINT fk_tournament_edition_league_tournament_edition FOREIGN KEY (id) REFERENCES ultical.TOURNAMENT_EDITION(id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('11', 'basil', 'db.changelog-1.0.xml', NOW(), 12, '7:29d3607d34a94786f86b999e07ab9cb9', 'createTable tableName=TOURNAMENT_EDITION_LEAGUE', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::12::basil
CREATE TABLE ultical.EVENT (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, matchday_number BIGINT DEFAULT -1 NOT NULL, tournament_edition BIGINT NOT NULL, location BIGINT NULL, start_date date NOT NULL, end_date date NOT NULL, local_organizer BIGINT NULL, CONSTRAINT PK_EVENT PRIMARY KEY (id));

ALTER TABLE ultical.EVENT ADD CONSTRAINT fk_event_tournament_edition FOREIGN KEY (tournament_edition) REFERENCES ultical.TOURNAMENT_EDITION (id) ON DELETE CASCADE;

ALTER TABLE ultical.EVENT ADD CONSTRAINT fk_event_contact FOREIGN KEY (local_organizer) REFERENCES ultical.CONTACT (id);

ALTER TABLE ultical.EVENT ADD CONSTRAINT fk_event_location FOREIGN KEY (location) REFERENCES ultical.LOCATION (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('12', 'basil', 'db.changelog-1.0.xml', NOW(), 13, '7:c5c9ec1c00bf07252b5a89bfdf28c682', 'createTable tableName=EVENT; addForeignKeyConstraint baseTableName=EVENT, constraintName=fk_event_tournament_edition, referencedTableName=TOURNAMENT_EDITION; addForeignKeyConstraint baseTableName=EVENT, constraintName=fk_event_contact, referencedT...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::13::basil
CREATE TABLE ultical.DIVISION_REGISTRATION (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, tournament_edition BIGINT NOT NULL, division_type VARCHAR(5) NOT NULL, division_age VARCHAR(12) NOT NULL, number_of_spots BIGINT NOT NULL, is_player_registration BIT(1) DEFAULT 0 NOT NULL, CONSTRAINT PK_DIVISION_REGISTRATION PRIMARY KEY (id));

ALTER TABLE ultical.DIVISION_REGISTRATION ADD CONSTRAINT fk_division_registration_tournament_edition FOREIGN KEY (tournament_edition) REFERENCES ultical.TOURNAMENT_EDITION (id) ON DELETE CASCADE;

ALTER TABLE ultical.DIVISION_REGISTRATION ADD UNIQUE (tournament_edition, division_type, division_age);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('13', 'basil', 'db.changelog-1.0.xml', NOW(), 14, '7:238415f2b08483512be9e4073a4af80b', 'createTable tableName=DIVISION_REGISTRATION; addForeignKeyConstraint baseTableName=DIVISION_REGISTRATION, constraintName=fk_division_registration_tournament_edition, referencedTableName=TOURNAMENT_EDITION; addUniqueConstraint tableName=DIVISION_RE...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::14::basil
CREATE TABLE ultical.TEAM_REGISTRATION (division_registration BIGINT NOT NULL, sequence BIGINT AUTO_INCREMENT NOT NULL, time_registered timestamp DEFAULT NOW() NOT NULL, team BIGINT NOT NULL, comment TEXT NULL, CONSTRAINT PK_TEAM_REGISTRATION PRIMARY KEY (sequence));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('14', 'basil', 'db.changelog-1.0.xml', NOW(), 15, '7:3f0a1372c582b55666619731edc00379', 'createTable tableName=TEAM_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::15::basil
CREATE TABLE ultical.TEAM (id BIGINT AUTO_INCREMENT NOT NULL, description TEXT NULL, founding_date INT NULL, location BIGINT NULL, version BIGINT DEFAULT 1 NOT NULL, name VARCHAR(255) NOT NULL, emails VARCHAR(255) NULL, url VARCHAR(255) NULL, contact_email VARCHAR(255) NULL, twitter_name VARCHAR(255) NULL, facebook_url VARCHAR(255) NULL, CONSTRAINT PK_TEAM PRIMARY KEY (id));

ALTER TABLE ultical.TEAM ADD CONSTRAINT fk_team_location FOREIGN KEY (location) REFERENCES ultical.LOCATION (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('15', 'basil', 'db.changelog-1.0.xml', NOW(), 16, '7:6af3f476bad67bf9f1e8302c3830d9af', 'createTable tableName=TEAM; addForeignKeyConstraint baseTableName=TEAM, constraintName=fk_team_location, referencedTableName=LOCATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::16::basil
ALTER TABLE ultical.TEAM_REGISTRATION ADD CONSTRAINT fk_team_registration_team FOREIGN KEY (team) REFERENCES ultical.TEAM (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('16', 'basil', 'db.changelog-1.0.xml', NOW(), 17, '7:d33f7023f1ab03a1bcfa03cb8f30760d', 'addForeignKeyConstraint baseTableName=TEAM_REGISTRATION, constraintName=fk_team_registration_team, referencedTableName=TEAM', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::17::basil
ALTER TABLE ultical.TEAM_REGISTRATION ADD CONSTRAINT fk_team_registration_division_registration FOREIGN KEY (division_registration) REFERENCES ultical.DIVISION_REGISTRATION (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('17', 'basil', 'db.changelog-1.0.xml', NOW(), 18, '7:0c3be72d0d743e7a28958843c8141f7b', 'addForeignKeyConstraint baseTableName=TEAM_REGISTRATION, constraintName=fk_team_registration_division_registration, referencedTableName=DIVISION_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::18::bas
CREATE TABLE ultical.DFV_MV_NAME (dfv_number BIGINT NOT NULL, first_name VARCHAR(255) NULL, last_name VARCHAR(255) NULL, dse BIT(1) DEFAULT 0 NOT NULL, CONSTRAINT PK_DFV_MV_NAME PRIMARY KEY (dfv_number));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('18', 'bas', 'db.changelog-1.0.xml', NOW(), 19, '7:4ff3c53bfe8b4180e9e9c1894d74818d', 'createTable tableName=DFV_MV_NAME', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::19::bas
CREATE TABLE ultical.TEAM_ULTICAL_USERS (team BIGINT NOT NULL, admin BIGINT NOT NULL, CONSTRAINT fk_team_ultical_users_ultical_users FOREIGN KEY (admin) REFERENCES ultical.ULTICAL_USER(id));

ALTER TABLE ultical.TEAM_ULTICAL_USERS ADD CONSTRAINT uk_team_ultical_users_team_admin UNIQUE (team, admin);

ALTER TABLE ultical.TEAM_ULTICAL_USERS ADD CONSTRAINT fk_team_ultical_users_team FOREIGN KEY (team) REFERENCES ultical.TEAM (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('19', 'bas', 'db.changelog-1.0.xml', NOW(), 20, '7:ee14194829fa1c20f6049d8ad7cbe292', 'createTable tableName=TEAM_ULTICAL_USERS; addUniqueConstraint constraintName=uk_team_ultical_users_team_admin, tableName=TEAM_ULTICAL_USERS; addForeignKeyConstraint baseTableName=TEAM_ULTICAL_USERS, constraintName=fk_team_ultical_users_team, refer...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::20::bas
CREATE TABLE ultical.ROSTER (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, team BIGINT NOT NULL, season BIGINT NOT NULL, division_age VARCHAR(12) NOT NULL, division_type VARCHAR(5) NOT NULL, CONSTRAINT PK_ROSTER PRIMARY KEY (id), CONSTRAINT fk_roster_season FOREIGN KEY (season) REFERENCES ultical.SEASON(id));

ALTER TABLE ultical.ROSTER ADD CONSTRAINT fk_roster_team FOREIGN KEY (team) REFERENCES ultical.TEAM (id) ON DELETE CASCADE;

ALTER TABLE ultical.ROSTER ADD CONSTRAINT uk_roster_team_season_division UNIQUE (team, season, division_type, division_age);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('20', 'bas', 'db.changelog-1.0.xml', NOW(), 21, '7:7e51f8dce64c20564557d5bcf40c1e3c', 'createTable tableName=ROSTER; addForeignKeyConstraint baseTableName=ROSTER, constraintName=fk_roster_team, referencedTableName=TEAM; addUniqueConstraint constraintName=uk_roster_team_season_division, tableName=ROSTER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::21::bas
CREATE TABLE ultical.ROSTER_PLAYERS (roster BIGINT NOT NULL, player BIGINT NOT NULL, date_added timestamp DEFAULT NOW() NOT NULL, CONSTRAINT PK_ROSTER_PLAYERS PRIMARY KEY (roster, player), CONSTRAINT fk_roster_players_player FOREIGN KEY (player) REFERENCES ultical.PLAYER(id));

ALTER TABLE ultical.ROSTER_PLAYERS ADD CONSTRAINT fk_roster_players_roster FOREIGN KEY (roster) REFERENCES ultical.ROSTER (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('21', 'bas', 'db.changelog-1.0.xml', NOW(), 22, '7:aa565cc5441ce1d847006527dc151798', 'createTable tableName=ROSTER_PLAYERS; addForeignKeyConstraint baseTableName=ROSTER_PLAYERS, constraintName=fk_roster_players_roster, referencedTableName=ROSTER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::22::bas
CREATE TABLE ultical.MAIL_CODE (ultical_user BIGINT NOT NULL, time_created timestamp DEFAULT NOW() NOT NULL, mail_code_type VARCHAR(16) NOT NULL, code VARCHAR(100) NOT NULL, CONSTRAINT PK_MAIL_CODE PRIMARY KEY (ultical_user, mail_code_type, code), CONSTRAINT uk_mail_code_code UNIQUE (code));

ALTER TABLE ultical.MAIL_CODE ADD CONSTRAINT fk_mail_code_ultical_user FOREIGN KEY (ultical_user) REFERENCES ultical.ULTICAL_USER (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('22', 'bas', 'db.changelog-1.0.xml', NOW(), 23, '7:68075e005588454d68586e57a14606b4', 'createTable tableName=MAIL_CODE; addForeignKeyConstraint baseTableName=MAIL_CODE, constraintName=fk_mail_code_ultical_user, referencedTableName=ULTICAL_USER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::23::bas
CREATE TABLE ultical.FEE_TOURNAMENT_EDITION (fee BIGINT NOT NULL, tournament_edition BIGINT NOT NULL, CONSTRAINT PK_FEE_TOURNAMENT_EDITION PRIMARY KEY (fee, tournament_edition));

ALTER TABLE ultical.FEE_TOURNAMENT_EDITION ADD CONSTRAINT fk_fee_tournament_edition_fee FOREIGN KEY (fee) REFERENCES ultical.FEE (id) ON DELETE CASCADE;

ALTER TABLE ultical.FEE_TOURNAMENT_EDITION ADD CONSTRAINT fk_fee_tournament_edition_tournament_edition FOREIGN KEY (tournament_edition) REFERENCES ultical.TOURNAMENT_EDITION (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('23', 'bas', 'db.changelog-1.0.xml', NOW(), 24, '7:86a7e6c17b15eb1b38481626da06569a', 'createTable tableName=FEE_TOURNAMENT_EDITION; addForeignKeyConstraint baseTableName=FEE_TOURNAMENT_EDITION, constraintName=fk_fee_tournament_edition_fee, referencedTableName=FEE; addForeignKeyConstraint baseTableName=FEE_TOURNAMENT_EDITION, constr...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::24::bas
CREATE TABLE ultical.FEE_EVENT (fee BIGINT NOT NULL, event BIGINT NOT NULL, CONSTRAINT PK_FEE_EVENT PRIMARY KEY (fee, event));

ALTER TABLE ultical.FEE_EVENT ADD CONSTRAINT fk_fee_event_fee FOREIGN KEY (fee) REFERENCES ultical.FEE (id) ON DELETE CASCADE;

ALTER TABLE ultical.FEE_EVENT ADD CONSTRAINT fk_fee_event_event FOREIGN KEY (event) REFERENCES ultical.EVENT (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('24', 'bas', 'db.changelog-1.0.xml', NOW(), 25, '7:6ea0457e7d8cd2e6d89ee7f6655a0c0b', 'createTable tableName=FEE_EVENT; addForeignKeyConstraint baseTableName=FEE_EVENT, constraintName=fk_fee_event_fee, referencedTableName=FEE; addForeignKeyConstraint baseTableName=FEE_EVENT, constraintName=fk_fee_event_event, referencedTableName=EVENT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::25::bas
CREATE TABLE ultical.CLUB (id BIGINT NOT NULL, name VARCHAR(255) NOT NULL, association BIGINT NULL, CONSTRAINT PK_CLUB PRIMARY KEY (id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('25', 'bas', 'db.changelog-1.0.xml', NOW(), 26, '7:3246f9792d34119321e4614d0ab39df7', 'createTable tableName=CLUB', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::26::bas
ALTER TABLE ultical.DFV_PLAYER ADD club BIGINT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('26', 'bas', 'db.changelog-1.0.xml', NOW(), 27, '7:d16df070600579bf2f906263448a4a68', 'addColumn tableName=DFV_PLAYER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::27::bas
ALTER TABLE ultical.DFV_PLAYER ADD CONSTRAINT fk_dfv_player_club FOREIGN KEY (club) REFERENCES ultical.CLUB (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('27', 'bas', 'db.changelog-1.0.xml', NOW(), 28, '7:8438e81ada9815b3031e316c98c5f884', 'addForeignKeyConstraint baseTableName=DFV_PLAYER, constraintName=fk_dfv_player_club, referencedTableName=CLUB', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::28::bas
ALTER TABLE ultical.DFV_MV_NAME ADD club BIGINT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('28', 'bas', 'db.changelog-1.0.xml', NOW(), 29, '7:8c1d7ab5455719f516f07a4edc21a171', 'addColumn tableName=DFV_MV_NAME', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::29::bas
ALTER TABLE ultical.TOURNAMENT_FORMAT ADD dfv_official BIT(1) DEFAULT 0 NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('29', 'bas', 'db.changelog-1.0.xml', NOW(), 30, '7:3dfe12edc0457aebf71620dbe73d426a', 'addColumn tableName=TOURNAMENT_FORMAT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::30::bas
ALTER TABLE ultical.TOURNAMENT_EDITION MODIFY registration_start date NULL;

ALTER TABLE ultical.TOURNAMENT_EDITION MODIFY registration_end date NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('30', 'bas', 'db.changelog-1.0.xml', NOW(), 31, '7:6629cbf5a8885bdf604a380e8bff6653', 'dropNotNullConstraint columnName=registration_start, tableName=TOURNAMENT_EDITION; dropNotNullConstraint columnName=registration_end, tableName=TOURNAMENT_EDITION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::31::bas
CREATE TABLE ultical.EVENT_ULTICAL_USERS (event BIGINT NOT NULL, admin BIGINT NOT NULL, CONSTRAINT fk_tevent_ultical_users_ultical_users FOREIGN KEY (admin) REFERENCES ultical.ULTICAL_USER(id));

ALTER TABLE ultical.EVENT_ULTICAL_USERS ADD CONSTRAINT fk_event_ultical_users_event FOREIGN KEY (event) REFERENCES ultical.EVENT (id) ON DELETE CASCADE;

ALTER TABLE ultical.EVENT_ULTICAL_USERS ADD CONSTRAINT uk_event_ultical_users_team_admin UNIQUE (event, admin);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('31', 'bas', 'db.changelog-1.0.xml', NOW(), 32, '7:2a6fb6b6bf846d57e0b0f2efeb13f58f', 'createTable tableName=EVENT_ULTICAL_USERS; addForeignKeyConstraint baseTableName=EVENT_ULTICAL_USERS, constraintName=fk_event_ultical_users_event, referencedTableName=EVENT; addUniqueConstraint constraintName=uk_event_ultical_users_team_admin, tab...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::32::bas
ALTER TABLE ultical.FEE CHANGE alternative_name other_name VARCHAR(100);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('32', 'bas', 'db.changelog-1.0.xml', NOW(), 33, '7:9f13f5fcd3b96007c7e5099c96f4b179', 'renameColumn newColumnName=other_name, oldColumnName=alternative_name, tableName=FEE', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::33::bas
DROP TABLE ultical.FEE_EVENT;

DROP TABLE ultical.FEE_TOURNAMENT_EDITION;

ALTER TABLE ultical.FEE ADD event BIGINT NULL;

ALTER TABLE ultical.FEE ADD tournament_edition BIGINT NULL;

ALTER TABLE ultical.FEE ADD CONSTRAINT fk_fee_event FOREIGN KEY (event) REFERENCES ultical.EVENT (id);

ALTER TABLE ultical.FEE ADD CONSTRAINT fk_fee_tournament_edition FOREIGN KEY (tournament_edition) REFERENCES ultical.TOURNAMENT_EDITION (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('33', 'bas', 'db.changelog-1.0.xml', NOW(), 34, '7:fb159a77241c9aaa06d556bd851b011a', 'dropTable tableName=FEE_EVENT; dropTable tableName=FEE_TOURNAMENT_EDITION; addColumn tableName=FEE; addColumn tableName=FEE; addForeignKeyConstraint baseTableName=FEE, constraintName=fk_fee_event, referencedTableName=EVENT; addForeignKeyConstraint...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::34::bas
DROP TABLE ultical.TOURNAMENT_EDITION_LEAGUE;

ALTER TABLE ultical.TOURNAMENT_EDITION ADD alternative_matchday_name VARCHAR(100) NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('34', 'bas', 'db.changelog-1.0.xml', NOW(), 35, '7:313ef8e53a9e8b4e272469ac12880518', 'dropTable tableName=TOURNAMENT_EDITION_LEAGUE; addColumn tableName=TOURNAMENT_EDITION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::35::bas
ALTER TABLE ultical.TOURNAMENT_EDITION DROP COLUMN is_league;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('35', 'bas', 'db.changelog-1.0.xml', NOW(), 36, '7:a2eabf9dcd24bbd1f49f789da8137007', 'dropColumn columnName=is_league, tableName=TOURNAMENT_EDITION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::36::bas
ALTER TABLE ultical.TEAM ADD club BIGINT NULL;

ALTER TABLE ultical.TEAM ADD CONSTRAINT fk_team_club FOREIGN KEY (club) REFERENCES ultical.CLUB (id) ON DELETE SET NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('36', 'bas', 'db.changelog-1.0.xml', NOW(), 37, '7:951658bd9e96aeb2f44164ad6f362aed', 'addColumn tableName=TEAM; addForeignKeyConstraint baseTableName=TEAM, constraintName=fk_team_club, referencedTableName=CLUB', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::37::bas
CREATE TABLE ultical.ASSOCIATION (id BIGINT NOT NULL, name VARCHAR(255) NOT NULL, contact BIGINT NULL, CONSTRAINT PK_ASSOCIATION PRIMARY KEY (id), CONSTRAINT uk_association_name UNIQUE (name));

ALTER TABLE ultical.ASSOCIATION ADD CONSTRAINT fk_association_contact FOREIGN KEY (contact) REFERENCES ultical.CONTACT (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('37', 'bas', 'db.changelog-1.0.xml', NOW(), 38, '7:5e8a52f21e052a6cfd33c42be5d2d0e5', 'createTable tableName=ASSOCIATION; addForeignKeyConstraint baseTableName=ASSOCIATION, constraintName=fk_association_contact, referencedTableName=CONTACT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::38::bas
ALTER TABLE ultical.CLUB ADD CONSTRAINT fk_club_association FOREIGN KEY (association) REFERENCES ultical.ASSOCIATION (id) ON DELETE SET NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('38', 'bas', 'db.changelog-1.0.xml', NOW(), 39, '7:3c12bb027d4ef1b2a5e643f429366529', 'addForeignKeyConstraint baseTableName=CLUB, constraintName=fk_club_association, referencedTableName=ASSOCIATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::39::bas
ALTER TABLE ultical.ASSOCIATION ADD acronym VARCHAR(10) NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('39', 'bas', 'db.changelog-1.0.xml', NOW(), 40, '7:baedae261b7abe037ada3240f37708ce', 'addColumn tableName=ASSOCIATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::40::bas
CREATE TABLE ultical.ASSOCIATION_ULTICAL_USERS (association BIGINT NOT NULL, admin BIGINT NOT NULL, CONSTRAINT PK_ASSOCIATION_ULTICAL_USERS PRIMARY KEY (association, admin));

ALTER TABLE ultical.ASSOCIATION_ULTICAL_USERS ADD CONSTRAINT fk_association_ultical_user_association FOREIGN KEY (association) REFERENCES ultical.ASSOCIATION (id) ON DELETE CASCADE;

ALTER TABLE ultical.ASSOCIATION_ULTICAL_USERS ADD CONSTRAINT fk_association_ultical_user_ultical_user FOREIGN KEY (admin) REFERENCES ultical.ULTICAL_USER (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('40', 'bas', 'db.changelog-1.0.xml', NOW(), 41, '7:a5da4021f521891b4ed4b4a30fdb5fa9', 'createTable tableName=ASSOCIATION_ULTICAL_USERS; addForeignKeyConstraint baseTableName=ASSOCIATION_ULTICAL_USERS, constraintName=fk_association_ultical_user_association, referencedTableName=ASSOCIATION; addForeignKeyConstraint baseTableName=ASSOCI...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas41::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas41', 'bas', 'db.changelog-1.0.xml', NOW(), 42, '7:4bd6474e24bf1169c7efea6dd8b3acab', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'v1.1');

--  Changeset db.changelog-1.0.xml::bas42::bas
ALTER TABLE ultical.TOURNAMENT_FORMAT ADD association BIGINT NULL;

ALTER TABLE ultical.TOURNAMENT_FORMAT ADD CONSTRAINT fk_tournament_format_association FOREIGN KEY (association) REFERENCES ultical.ASSOCIATION (id);

ALTER TABLE ultical.TOURNAMENT_FORMAT DROP COLUMN dfv_official;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas42', 'bas', 'db.changelog-1.0.xml', NOW(), 43, '7:94012ddcd382d94d3f6e3ae970036735', 'addColumn tableName=TOURNAMENT_FORMAT; addForeignKeyConstraint baseTableName=TOURNAMENT_FORMAT, constraintName=fk_tournament_format_association, referencedTableName=ASSOCIATION; dropColumn columnName=dfv_official, tableName=TOURNAMENT_FORMAT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas43::bas
ALTER TABLE ultical.DIVISION_REGISTRATION ADD division_identifier VARCHAR(50) DEFAULT '' NOT NULL;

ALTER TABLE ultical.DIVISION_REGISTRATION ADD CONSTRAINT uk_division_registration_edition_division UNIQUE (tournament_edition, division_type, division_age, division_identifier);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas43', 'bas', 'db.changelog-1.0.xml', NOW(), 44, '7:278c2ab3e85c38cd8ec102448b0e6d95', 'addColumn tableName=DIVISION_REGISTRATION; addUniqueConstraint constraintName=uk_division_registration_edition_division, tableName=DIVISION_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas44::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas44', 'bas', 'db.changelog-1.0.xml', NOW(), 45, '7:010a32e7565947eb0d92fd642e0e09e4', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'v1.2');

--  Changeset db.changelog-1.0.xml::bas45::bas
CREATE TABLE ultical.EVENT_LOCATION (event BIGINT NOT NULL, location BIGINT NOT NULL);

ALTER TABLE ultical.EVENT_LOCATION ADD CONSTRAINT fk_event_location_event FOREIGN KEY (event) REFERENCES ultical.EVENT (id) ON DELETE CASCADE;

ALTER TABLE ultical.EVENT_LOCATION ADD CONSTRAINT fk_event_location_location FOREIGN KEY (location) REFERENCES ultical.LOCATION (id) ON DELETE CASCADE;

ALTER TABLE ultical.EVENT DROP FOREIGN KEY fk_event_location;

ALTER TABLE ultical.EVENT DROP COLUMN location;

ALTER TABLE ultical.LOCATION ADD title VARCHAR(100) NULL, ADD is_main BIT(1) DEFAULT 0 NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas45', 'bas', 'db.changelog-1.0.xml', NOW(), 46, '7:4de034c0c2b85d733d6b6726cf0253b3', 'createTable tableName=EVENT_LOCATION; addForeignKeyConstraint baseTableName=EVENT_LOCATION, constraintName=fk_event_location_event, referencedTableName=EVENT; addForeignKeyConstraint baseTableName=EVENT_LOCATION, constraintName=fk_event_location_l...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas46::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas46', 'bas', 'db.changelog-1.0.xml', NOW(), 47, '7:a36425cbf0ba0b0dc400634e396f7790', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.3');

--  Changeset db.changelog-1.0.xml::bas47::bas
ALTER TABLE ultical.LOCATION CHANGE zip_code zip_code_int BIGINT;

ALTER TABLE ultical.LOCATION ADD zip_code VARCHAR(20) NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas47', 'bas', 'db.changelog-1.0.xml', NOW(), 48, '7:94e3e2606e4885edd729c11f0a066cdb', 'renameColumn newColumnName=zip_code_int, oldColumnName=zip_code, tableName=LOCATION; addColumn tableName=LOCATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas48::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas48', 'bas', 'db.changelog-1.0.xml', NOW(), 49, '7:c9d3d5f3cfeead7fd8c6ed44b6900fda', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.4');

--  Changeset db.changelog-1.0.xml::bas49::bas
ALTER TABLE ultical.DIVISION_REGISTRATION ALTER division_identifier DROP DEFAULT;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas49', 'bas', 'db.changelog-1.0.xml', NOW(), 50, '7:37dfc2061b3227101969bdc68a78c9a0', 'dropDefaultValue columnName=division_identifier, tableName=DIVISION_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas50::bas
ALTER TABLE ultical.TEAM DROP FOREIGN KEY fk_team_location;

ALTER TABLE ultical.TEAM ADD CONSTRAINT fk_team_location FOREIGN KEY (location) REFERENCES ultical.LOCATION (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas50', 'bas', 'db.changelog-1.0.xml', NOW(), 51, '7:8bdbb0b8eb658d441737b1700a155f46', 'dropForeignKeyConstraint baseTableName=TEAM, constraintName=fk_team_location; addForeignKeyConstraint baseTableName=TEAM, constraintName=fk_team_location, referencedTableName=LOCATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas51::bas
DROP TABLE ultical.TEAM_REGISTRATION;

CREATE TABLE ultical.TEAM_REGISTRATION (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, division_registration BIGINT NOT NULL, time_registered timestamp DEFAULT NOW() NOT NULL, team BIGINT NOT NULL, comment TEXT NULL, sequence SMALLINT NULL, standing SMALLINT NULL, spirit_score FLOAT(4) NULL, paid BIT(1) DEFAULT 0 NULL, status VARCHAR(20) DEFAULT 'PENDING' NOT NULL, not_qualified BIT(1) DEFAULT 0 NULL, CONSTRAINT PK_TEAM_REGISTRATION PRIMARY KEY (id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas51', 'bas', 'db.changelog-1.0.xml', NOW(), 52, '7:c6daf7bfe4ed390ec060f9766f9f2aab', 'dropTable tableName=TEAM_REGISTRATION; createTable tableName=TEAM_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas52::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas52', 'bas', 'db.changelog-1.0.xml', NOW(), 53, '7:43c1e0ab5ef08d69edc0cad6f405ec33', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.5');

--  Changeset db.changelog-1.0.xml::bas53::bas
ALTER TABLE ultical.EVENT ADD info TEXT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas53', 'bas', 'db.changelog-1.0.xml', NOW(), 54, '7:680a49691486e48c57980efc4f85b2ca', 'addColumn tableName=EVENT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas54::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas54', 'bas', 'db.changelog-1.0.xml', NOW(), 55, '7:f26767bbe6fb114b20e51361c65a3312', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.6');

--  Changeset db.changelog-1.0.xml::bas55::bas
ALTER TABLE ultical.LOCATION DROP COLUMN zip_code_int;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas55', 'bas', 'db.changelog-1.0.xml', NOW(), 56, '7:def2419884ede74c5484817fb5e67554', 'dropColumn columnName=zip_code_int, tableName=LOCATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas56::bas
ALTER TABLE ultical.TEAM_REGISTRATION ADD CONSTRAINT fk_team_registration_team FOREIGN KEY (team) REFERENCES ultical.TEAM (id);

ALTER TABLE ultical.TEAM_REGISTRATION ADD CONSTRAINT fk_team_registration_division_registration FOREIGN KEY (division_registration) REFERENCES ultical.DIVISION_REGISTRATION (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas56', 'bas', 'db.changelog-1.0.xml', NOW(), 57, '7:8a4eac18283f562ff38138056559d4d9', 'addForeignKeyConstraint baseTableName=TEAM_REGISTRATION, constraintName=fk_team_registration_team, referencedTableName=TEAM; addForeignKeyConstraint baseTableName=TEAM_REGISTRATION, constraintName=fk_team_registration_division_registration, refere...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas57::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas57', 'bas', 'db.changelog-1.0.xml', NOW(), 58, '7:5f059f9229e5adad90e7ac4c87a5dfa8', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.7');

--  Changeset db.changelog-1.0.xml::bas58::bas
ALTER TABLE ultical.FEE ADD per_person BIT(1) DEFAULT 0 NULL, ADD multiple BIT(1) DEFAULT 0 NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas58', 'bas', 'db.changelog-1.0.xml', NOW(), 59, '7:2a7ca8dcd68e078fa348e36a2b24a379', 'addColumn tableName=FEE', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas59::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas59', 'bas', 'db.changelog-1.0.xml', NOW(), 60, '7:222764530d91cc05b1470859301caf07', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.8');

--  Changeset db.changelog-1.0.xml::bas60::bas
ALTER TABLE ultical.TEAM_REGISTRATION ADD CONSTRAINT uk_team_registration_division_registration_team UNIQUE (division_registration, team);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas60', 'bas', 'db.changelog-1.0.xml', NOW(), 61, '7:180499dd76719eaa538dd3dfa2288139', 'addUniqueConstraint constraintName=uk_team_registration_division_registration_team, tableName=TEAM_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas61::bas
ALTER TABLE ultical.ASSOCIATION ADD version BIGINT DEFAULT 1 NULL;

ALTER TABLE ultical.CLUB ADD version BIGINT DEFAULT 1 NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas61', 'bas', 'db.changelog-1.0.xml', NOW(), 62, '7:22709919a593b5e9d52ce249b477544f', 'addColumn tableName=ASSOCIATION; addColumn tableName=CLUB', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas62::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas62', 'bas', 'db.changelog-1.0.xml', NOW(), 63, '7:00097c0dcd75388a5971433d06ce3ff9', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.9');

--  Changeset db.changelog-1.0.xml::bas63::bas
CREATE TABLE ultical.DIVISION_CONFIRMATION (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NULL, division_registration BIGINT NOT NULL, event BIGINT NOT NULL, CONSTRAINT PK_DIVISION_CONFIRMATION PRIMARY KEY (id));

ALTER TABLE ultical.DIVISION_CONFIRMATION ADD CONSTRAINT uk_division_confirmation_division_registration_event UNIQUE (division_registration, event);

ALTER TABLE ultical.DIVISION_CONFIRMATION ADD CONSTRAINT fk_division_confirmation_division_registration FOREIGN KEY (division_registration) REFERENCES ultical.DIVISION_REGISTRATION (id);

ALTER TABLE ultical.DIVISION_CONFIRMATION ADD CONSTRAINT fk_division_confirmation_event FOREIGN KEY (event) REFERENCES ultical.EVENT (id);

CREATE TABLE ultical.DIVISION_CONFIRMATION_TEAMS (division_confirmation BIGINT NOT NULL, team_registration BIGINT NOT NULL, CONSTRAINT PK_DIVISION_CONFIRMATION_TEAMS PRIMARY KEY (division_confirmation, team_registration));

ALTER TABLE ultical.DIVISION_CONFIRMATION_TEAMS ADD CONSTRAINT fk_division_confirmation_teams_division_confirmation FOREIGN KEY (division_confirmation) REFERENCES ultical.DIVISION_CONFIRMATION (id);

ALTER TABLE ultical.DIVISION_CONFIRMATION_TEAMS ADD CONSTRAINT fk_division_confirmation_teams_team_registration FOREIGN KEY (team_registration) REFERENCES ultical.TEAM_REGISTRATION (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas63', 'bas', 'db.changelog-1.0.xml', NOW(), 64, '7:5b123e9d9e175cf96002ef4657a0ade6', 'createTable tableName=DIVISION_CONFIRMATION; addUniqueConstraint constraintName=uk_division_confirmation_division_registration_event, tableName=DIVISION_CONFIRMATION; addForeignKeyConstraint baseTableName=DIVISION_CONFIRMATION, constraintName=fk_d...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas64::bas
ALTER TABLE ultical.DIVISION_CONFIRMATION MODIFY version BIGINT NOT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas64', 'bas', 'db.changelog-1.0.xml', NOW(), 65, '7:2e2a9bb2c8a82ee41c062998770a74a5', 'addNotNullConstraint columnName=version, tableName=DIVISION_CONFIRMATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas65::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas65', 'bas', 'db.changelog-1.0.xml', NOW(), 66, '7:705317d61862a97215c8bfca7d165533', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.10');

--  Changeset db.changelog-1.0.xml::bas66::bas
ALTER TABLE ultical.DIVISION_CONFIRMATION ADD individual_assignment BIT(1) DEFAULT 0 NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas66', 'bas', 'db.changelog-1.0.xml', NOW(), 67, '7:cc4cfa82bb84ea14d4a8f90cc6c9866d', 'addColumn tableName=DIVISION_CONFIRMATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas67::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas67', 'bas', 'db.changelog-1.0.xml', NOW(), 68, '7:8c8691abd2b3b4fee0bb43f08570150e', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.11');

--  Changeset db.changelog-1.0.xml::bas68::bas
CREATE TABLE ultical.CONTEXT (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, name VARCHAR(50) NOT NULL, acronym VARCHAR(10) NOT NULL, CONSTRAINT PK_CONTEXT PRIMARY KEY (id), CONSTRAINT uk_context_acronym UNIQUE (acronym));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas68', 'bas', 'db.changelog-1.0.xml', NOW(), 69, '7:95e37c83d30d51a76809535bce555405', 'createTable tableName=CONTEXT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas69::bas
ALTER TABLE ultical.ROSTER ADD name_addition VARCHAR(10) DEFAULT '' NOT NULL, ADD context BIGINT NULL;

ALTER TABLE ultical.ROSTER ADD CONSTRAINT fk_roster_context FOREIGN KEY (context) REFERENCES ultical.CONTEXT (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas69', 'bas', 'db.changelog-1.0.xml', NOW(), 70, '7:cad20ea48714eba8e224397f7fc7c72d', 'addColumn tableName=ROSTER; addForeignKeyConstraint baseTableName=ROSTER, constraintName=fk_roster_context, referencedTableName=CONTEXT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas70::bas
ALTER TABLE ultical.TEAM_REGISTRATION ADD roster BIGINT NULL;

ALTER TABLE ultical.TEAM_REGISTRATION ADD CONSTRAINT fk_team_registration_roster FOREIGN KEY (roster) REFERENCES ultical.ROSTER (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas70', 'bas', 'db.changelog-1.0.xml', NOW(), 71, '7:c36fc61667880ce70bdc05050847978c', 'addColumn tableName=TEAM_REGISTRATION; addForeignKeyConstraint baseTableName=TEAM_REGISTRATION, constraintName=fk_team_registration_roster, referencedTableName=ROSTER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas71::bas
ALTER TABLE ultical.ROSTER DROP FOREIGN KEY fk_roster_season;

ALTER TABLE ultical.ROSTER DROP FOREIGN KEY fk_roster_team;

ALTER TABLE ultical.ROSTER DROP KEY uk_roster_team_season_division;

ALTER TABLE ultical.ROSTER ADD CONSTRAINT fk_roster_season FOREIGN KEY (season) REFERENCES ultical.SEASON (id);

ALTER TABLE ultical.ROSTER ADD CONSTRAINT fk_roster_team FOREIGN KEY (team) REFERENCES ultical.TEAM (id);

ALTER TABLE ultical.ROSTER ADD CONSTRAINT uk_roster_team_season_division_addition_context UNIQUE (team, season, division_type, division_age, name_addition, context);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas71', 'bas', 'db.changelog-1.0.xml', NOW(), 72, '7:1946f9b5e01a2a5eff6c1e9a8d2f6b3d', 'dropForeignKeyConstraint baseTableName=ROSTER, constraintName=fk_roster_season; dropForeignKeyConstraint baseTableName=ROSTER, constraintName=fk_roster_team; dropUniqueConstraint constraintName=uk_roster_team_season_division, tableName=ROSTER; add...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas72::bas
ALTER TABLE ultical.TOURNAMENT_EDITION ADD context BIGINT NULL;

ALTER TABLE ultical.TOURNAMENT_EDITION ADD CONSTRAINT fk_tournament_edition_context FOREIGN KEY (context) REFERENCES ultical.CONTEXT (id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas72', 'bas', 'db.changelog-1.0.xml', NOW(), 73, '7:9bfbc7d449b1a88ca22bb6a8b1d56fdb', 'addColumn tableName=TOURNAMENT_EDITION; addForeignKeyConstraint baseTableName=TOURNAMENT_EDITION, constraintName=fk_tournament_edition_context, referencedTableName=CONTEXT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas73::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas73', 'bas', 'db.changelog-1.0.xml', NOW(), 74, '7:def3f94a40cfa37610fc5912db15c438', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.12');

--  Changeset db.changelog-1.0.xml::bas74::bas
ALTER TABLE ultical.TEAM_REGISTRATION DROP FOREIGN KEY fk_team_registration_division_registration;

ALTER TABLE ultical.TEAM_REGISTRATION DROP FOREIGN KEY fk_team_registration_team;

ALTER TABLE ultical.TEAM_REGISTRATION DROP KEY uk_team_registration_division_registration_team;

ALTER TABLE ultical.TEAM_REGISTRATION MODIFY team BIGINT NULL;

ALTER TABLE ultical.TEAM_REGISTRATION ADD CONSTRAINT fk_team_registration_division_registration FOREIGN KEY (division_registration) REFERENCES ultical.DIVISION_REGISTRATION (id);

ALTER TABLE ultical.TEAM_REGISTRATION ADD CONSTRAINT uk_team_registration_division_registration_roster UNIQUE (division_registration, roster);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas74', 'bas', 'db.changelog-1.0.xml', NOW(), 75, '7:f347f7e844276879375b79496f86351e', 'dropForeignKeyConstraint baseTableName=TEAM_REGISTRATION, constraintName=fk_team_registration_division_registration; dropForeignKeyConstraint baseTableName=TEAM_REGISTRATION, constraintName=fk_team_registration_team; dropUniqueConstraint constrain...', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas75::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas75', 'bas', 'db.changelog-1.0.xml', NOW(), 76, '7:18c5bef1ba6b6aa42e57784ac0dc1f56', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.13');

--  Changeset db.changelog-1.0.xml::bas76::bas
UPDATE TEAM_REGISTRATION tr2 SET
			roster = (
			SELECT r.id
			FROM ROSTER r
			LEFT JOIN TEAM t ON r.team = t.id
			LEFT JOIN (SELECT * FROM TEAM_REGISTRATION) tr ON tr.team = t.id
			LEFT
			JOIN DIVISION_REGISTRATION dr ON tr.division_registration = dr.id
			LEFT JOIN TOURNAMENT_EDITION te ON dr.tournament_edition = te.id
			WHERE dr.division_type = r.division_type
			AND dr.division_age =
			r.division_age
			AND te.season = r.season
			AND r.name_addition = ''
			AND
			tr.id = tr2.id);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas76', 'bas', 'db.changelog-1.0.xml', NOW(), 77, '7:a0dbe6162dcb16b081d97a4be7047430', 'sql', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas77::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas77', 'bas', 'db.changelog-1.0.xml', NOW(), 78, '7:dce3babd9b907dcd955153765b8c3d4b', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.14');

--  Changeset db.changelog-1.0.xml::bas78::bas
INSERT INTO ultical.CONTEXT (id, name, acronym) VALUES ('1', 'Deutscher Frisbeesport-Verband', 'DFV');

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas78', 'bas', 'db.changelog-1.0.xml', NOW(), 79, '7:603986d8082a6ca305c28fcc57bfe154', 'insert tableName=CONTEXT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas79::bas
UPDATE ROSTER r SET context = 1
			WHERE context IS NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas79', 'bas', 'db.changelog-1.0.xml', NOW(), 80, '7:b23b54ec40b2b2d3ef28bba7cddee5ab', 'sql', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas80::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas80', 'bas', 'db.changelog-1.0.xml', NOW(), 81, '7:b1a9801dff01a9cc5fe8fc0e3e0255b7', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_v1.15');

--  Changeset db.changelog-1.0.xml::bas81::bas
ALTER TABLE ultical.TEAM_REGISTRATION DROP COLUMN team;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas81', 'bas', 'db.changelog-1.0.xml', NOW(), 82, '7:15a4aca94fbaf277d76832fbe46287d4', 'dropColumn columnName=team, tableName=TEAM_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas82::bas
ALTER TABLE ultical.TEAM_REGISTRATION ADD own_spirit_score FLOAT(4) NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas82', 'bas', 'db.changelog-1.0.xml', NOW(), 83, '7:40fb4f63791bacb4cc2769ae0d5b0c8f', 'addColumn tableName=TEAM_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas83::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas83', 'bas', 'db.changelog-1.0.xml', NOW(), 84, '7:a1c14faa1e3cf49d070e9d80bdb944c4', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'ultical_bas_v.1.16');

--  Changeset db.changelog-1.0.xml::bb84::bb
ALTER TABLE ultical.DFV_MV_NAME ADD last_modified timestamp NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bb84', 'bb', 'db.changelog-1.0.xml', NOW(), 85, '7:c5587cdc3ca30bf9a0f6b5bc0818c2e0', 'addColumn tableName=DFV_MV_NAME', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bb85::bb
UPDATE ultical.DFV_MV_NAME SET last_modified = '2016-01-01' WHERE last_modified IS NULL;

ALTER TABLE ultical.DFV_MV_NAME MODIFY last_modified timestamp NOT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bb85', 'bb', 'db.changelog-1.0.xml', NOW(), 86, '7:7a456fbad06f2de212e949a6437d7321', 'addNotNullConstraint columnName=last_modified, tableName=DFV_MV_NAME', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bb86::bb
ALTER TABLE ultical.DFV_PLAYER ADD last_modified timestamp DEFAULT '2016-01-01 00:00:00.000' NOT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bb86', 'bb', 'db.changelog-1.0.xml', NOW(), 87, '7:302a741f8636f5a9df3516fa04b7a0ee', 'addColumn tableName=DFV_PLAYER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-editionshow-1::bas
ALTER TABLE ultical.TOURNAMENT_EDITION ADD name VARCHAR(200) NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-editionshow-1', 'bas', 'db.changelog-1.0.xml', NOW(), 88, '7:47f725aee53cd8d28cff29610ffc81f1', 'addColumn tableName=TOURNAMENT_EDITION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-editionshow-2::bas
UPDATE TOURNAMENT_EDITION SET name
			= alternative_name;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-editionshow-2', 'bas', 'db.changelog-1.0.xml', NOW(), 89, '7:32124af038c60cbf0c849734fc3f5dd7', 'sql', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-editionshow-3::bas
ALTER TABLE ultical.TOURNAMENT_EDITION DROP COLUMN alternative_name;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-editionshow-3', 'bas', 'db.changelog-1.0.xml', NOW(), 90, '7:ba4374f43db6aff1e95c0b8bf28c8f6e', 'dropColumn columnName=alternative_name, tableName=TOURNAMENT_EDITION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-editionshow-4::bas
ALTER TABLE ultical.EVENT ADD name VARCHAR(200) NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-editionshow-4', 'bas', 'db.changelog-1.0.xml', NOW(), 91, '7:83038df09c3e007a6727d9d5504bca18', 'addColumn tableName=EVENT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-editionshow-5::bas
UPDATE EVENT SET name = (SELECT
			name FROM TOURNAMENT_EDITION WHERE id = EVENT.tournament_edition);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-editionshow-5', 'bas', 'db.changelog-1.0.xml', NOW(), 92, '7:acaeb1ad28335cff62ef21bc3d46f46d', 'sql', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-editionshow-6::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas-editionshow-6', 'bas', 'db.changelog-1.0.xml', NOW(), 93, '7:cd10087a06207f02cd075d1870c501d2', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_editionshow_v.1.16');

--  Changeset db.changelog-1.0.xml::bas84::bas
ALTER TABLE ultical.EVENT_LOCATION ADD PRIMARY KEY (event, location);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas84', 'bas', 'db.changelog-1.0.xml', NOW(), 94, '7:52c6118a7c18dcf3ffeacbe28171195f', 'addPrimaryKey tableName=EVENT_LOCATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas85::bas
ALTER TABLE ultical.DIVISION_CONFIRMATION ALTER version SET DEFAULT 1;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas85', 'bas', 'db.changelog-1.0.xml', NOW(), 95, '7:425e3010d08ebf5b1f12809d90591cf0', 'addDefaultValue columnName=version, tableName=DIVISION_CONFIRMATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-teamregistration-1::bas
ALTER TABLE ultical.TOURNAMENT_EDITION ADD allow_event_team_reg_management BIT(1) DEFAULT 1 NOT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-teamregistration-1', 'bas', 'db.changelog-1.0.xml', NOW(), 96, '7:04bdbe3bf1588cc089ab0178f458687f', 'addColumn tableName=TOURNAMENT_EDITION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-tag-86::bas
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bas-tag-86', 'bas', 'db.changelog-1.0.xml', NOW(), 97, '7:3926456adf52485a17c48ebffdfefaa1', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'bas_teamregistration-v.1.17');

--  Changeset db.changelog-1.0.xml::bas-resources-1::bas
CREATE TABLE ultical.RESOURCE (id BIGINT AUTO_INCREMENT NOT NULL, version BIGINT DEFAULT 1 NOT NULL, title VARCHAR(100) NOT NULL, path VARCHAR(255) NOT NULL, local BIT(1) NOT NULL, event BIGINT NULL, CONSTRAINT PK_RESOURCE PRIMARY KEY (id));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-resources-1', 'bas', 'db.changelog-1.0.xml', NOW(), 98, '7:9364156606d36c255f3b24ada543e5ab', 'createTable tableName=RESOURCE', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-resources-2::bas
ALTER TABLE ultical.RESOURCE ADD CONSTRAINT fk_resource_event FOREIGN KEY (event) REFERENCES ultical.EVENT (id) ON DELETE CASCADE;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-resources-2', 'bas', 'db.changelog-1.0.xml', NOW(), 99, '7:7a8d5a4ed1fec9dfaa064b579675d88d', 'addForeignKeyConstraint baseTableName=RESOURCE, constraintName=fk_resource_event, referencedTableName=EVENT', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-resources-3::bas
ALTER TABLE ultical.RESOURCE ADD CONSTRAINT uk_resource_path_event UNIQUE (path, event);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-resources-3', 'bas', 'db.changelog-1.0.xml', NOW(), 100, '7:107a51eea62b1a957afea951513e1538', 'addUniqueConstraint constraintName=uk_resource_path_event, tableName=RESOURCE', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-div-1::bas
ALTER TABLE ultical.TOURNAMENT_FORMAT_ULTICAL_USERS ADD CONSTRAINT uk_tournament_format_ultical_users UNIQUE (tournament_format, admin);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-div-1', 'bas', 'db.changelog-1.0.xml', NOW(), 101, '7:6eef5421de71c4bac885f23cf64adad1', 'addUniqueConstraint constraintName=uk_tournament_format_ultical_users, tableName=TOURNAMENT_FORMAT_ULTICAL_USERS', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bb-eligible-1::bb
ALTER TABLE ultical.DFV_PLAYER ADD eligible_until timestamp DEFAULT null NULL;

UPDATE ultical.DFV_PLAYER SET eligible_until = NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bb-eligible-1', 'bb', 'db.changelog-1.0.xml', NOW(), 102, '7:4ec6d015cc8ef3ffff96d59a8cf44c11', 'addColumn tableName=DFV_PLAYER', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bb-eligible-2::bb
INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID, TAG) VALUES ('bb-eligible-2', 'bb', 'db.changelog-1.0.xml', NOW(), 103, '7:30b0b1acde5bbf3fd907a4042227c751', 'tagDatabase', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869', 'v1.18');

--  Changeset db.changelog-1.0.xml::bas-bugfix-reserved-words::bas
ALTER TABLE ultical.RESOURCE CHANGE path location_path VARCHAR(255);

ALTER TABLE ultical.RESOURCE CHANGE local is_local BIT(1);

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-bugfix-reserved-words', 'bas', 'db.changelog-1.0.xml', NOW(), 104, '7:ac7c47bd8fed346c64371c30d1fb3e97', 'renameColumn newColumnName=location_path, oldColumnName=path, tableName=RESOURCE; renameColumn newColumnName=is_local, oldColumnName=local, tableName=RESOURCE', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-bugfix-reserved-words-2::bas
ALTER TABLE ultical.RESOURCE MODIFY location_path VARCHAR(255) NOT NULL;

ALTER TABLE ultical.RESOURCE MODIFY is_local BIT(1) NOT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-bugfix-reserved-words-2', 'bas', 'db.changelog-1.0.xml', NOW(), 105, '7:a3f141e0744142fd88ab1899de89ba05', 'addNotNullConstraint columnName=location_path, tableName=RESOURCE; addNotNullConstraint columnName=is_local, tableName=RESOURCE', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-team-renames-1::bas
ALTER TABLE ultical.TEAM_REGISTRATION ADD team_name VARCHAR(255) DEFAULT '' NOT NULL;

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-team-renames-1', 'bas', 'db.changelog-1.0.xml', NOW(), 106, '7:67217e2f8cf3a0d0eca5897798857cd9', 'addColumn tableName=TEAM_REGISTRATION', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Changeset db.changelog-1.0.xml::bas-team-renames-2::bas
UPDATE TEAM_REGISTRATION SET
			team_name = (TRIM((SELECT
			CONCAT_WS (' ', TEAM.name,
			ROSTER.name_addition) FROM TEAM LEFT JOIN ROSTER ON ROSTER.team =
			TEAM.id WHERE ROSTER.id = TEAM_REGISTRATION.roster)));

INSERT INTO ultical.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE, DEPLOYMENT_ID) VALUES ('bas-team-renames-2', 'bas', 'db.changelog-1.0.xml', NOW(), 107, '7:e3b52a4cb9c3887ba1783661a845bfd6', 'sql', '', 'EXECUTED', NULL, NULL, '3.5.3', '9555095869');

--  Release Database Lock
UPDATE ultical.DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

