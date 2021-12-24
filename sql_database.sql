-- ΠΡΟΟΡΙΣΜΟΣ 
DROP TABLE IF EXISTS "DESTINATION";
 CREATE TABLE IF NOT EXISTS "DESTINATION"(
    'id_aerodromio_destination' INTEGER NOT NULL,
    'id_grammi_destination' INTEGER NOT NULL,
    'ID_destination' INTEGER NOT NULL,
    PRIMARY KEY('ID_destination')
    CONSTRAINT "id_aerodromio_destination_FK" FOREIGN KEY ('id_aerodromio_destination') REFERENCES 'DESTINATION' ('id_aerodromio_destination') ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "id_grammi_destination_FK" FOREIGN KEY ('id_grammi_destination') REFERENCES 'DESTINATION' ('id_grammi_destination') ON DELETE CASCADE ON UPDATE CASCADE
 ); 

 --ΑΦΙΞΗ 
 DROP TABLE IF EXISTS "DEPARTURE";
 CREATE TABLE IF NOT EXISTS "DEPARTURE"(
     'id_aerodromio_departure' INTEGER NOT NULL,
     'id_grammi_departure' INTEGER NOT NULL,
     'ID_departure' INTEGER NOT NULL,
    PRIMARY KEY('ID_departure')
    CONSTRAINT "id_aerodromio_departure_FK" FOREIGN KEY ('id_aerodromio_departure') REFERENCES 'DEPARTURE' ('id_aerodromio_depsrture') ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "id_grammi_departure_FK" FOREIGN KEY ('id_grammi_departure') REFERENCES 'DEPARTURE' ('id_grammi_despsrture') ON DELETE CASCADE ON UPDATE CASCADE
 );
 
 --ΕΝΔΙΑΜΕΣΟΣ ΣΤΑΘΜΟΣ
  DROP TABLE IF EXISTS "MID";
 CREATE TABLE IF NOT EXISTS "DEPARTURE"(
     'id_aerodromio_mid' INTEGER NOT NULL,
     'id_grammi_mid' INTEGER NOT NULL,
     'ID_mid' INTEGER NOT NULL,
    PRIMARY KEY('ID_mid')
    CONSTRAINT "id_aerodromio_mid_FK" FOREIGN KEY ('id_aerodromio_mid') REFERENCES 'DESTINATION' ('id_aerodromio_mid') ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "id_grammi_mid_FK" FOREIGN KEY ('id_grammi_mid') REFERENCES 'DESTINATION' ('id_grammi_mid') ON DELETE CASCADE ON UPDATE CASCADE
 )