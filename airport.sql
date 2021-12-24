BEGIN TRANSACTION;
--ΠΤΗΣΗ
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
--ΓΡΑΜΜΗ
DROP TABLE IF EXISTS "LINE";
CREATE TABLE IF NOT EXISTS "LINE"(
    'id_line' integer NOT NULL
    'date_line' datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
    PRIMARY KEY ('id_line')
 );
--ΑΕΡΟΠΛΑΝΟ
 DROP TABLE IF EXISTS "AIRPLANE";
 CREATE TABLE IF NOT EXISTS "AIRPLANE"(
    'id_airplane' integer NOT NULL
    'name_airplane' varchar(20) NOT NULL
    'seats' integer NOT NULL
    'baggage' integer NOT NULL
    'id_airline' integer NOT NULL
    'name_category' varchar(30) NOT NULL
    PRIMARY KEY('id_airplane')
    CONSTRAINT "airplane_category_FK" FOREIGN KEY ('name_category') REFERENCES 'CATEGORY' ('name_category') ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "airplane_airline_FK" FOREIGN KEY ('id_airline') REFERENCES 'AIRLINE' ('id_airline') ON DELETE CASCADE ON UPDATE CASCADE
 );
--ΚΑΤΗΓΟΡΙΑ
 DROP TABLE IF EXISTS "CATEGORY";
 CREATE TABLE IF NOT EXISTS "CATEGORY"(
     'name_category' varchar(30) NOT NULL
    PRIMARY KEY('name_category')
 );

 