BEGIN TRANSACTION;

DROP TABLE IF EXISTS "FLIGHT";
CREATE TABLE IF NOT EXISTS "FLIGHT"(
    'id_flight' integer NOT NULL
    'id_airplane' varchar(15) NOT NULL
    'date_flight' datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
    'id_line' integer NOT NULL
    PRIMARY KEY('id_flight')
    CONSTRAINT "flight_airplane_FK" FOREIGN KEY ('id_airplane') REFERENCES 'AIRPLANE' ('id_airplane') ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "flight_line_FK" FOREIGN KEY ('id_line') REFERENCES 'LINE' ('id_line') ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS "LINE";
CREATE TABLE IF NOT EXISTS "LINE"(
    'id_line' integer NOT NULL
    'date_line' datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
    PRIMARY KEY ('id_line')
 );

 DROP TABLE IF EXISTS "AIRPLANE";
 CREATE TABLE IF NOT EXISTS "AIRPLANE"(
     
 )