BEGIN TRANSACTION;
--ΠΤΗΣΗ
DROP TABLE IF EXISTS "FLIGHT";
CREATE TABLE IF NOT EXISTS "FLIGHT"(
    "id_flight" integer NOT NULL,
    "id_airplane" varchar(15) NOT NULL,
    "date_flight" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    "id_line" integer NOT NULL,
    "name_terminal" varchar(15) NOT NULL,
    PRIMARY KEY("id_flight"),
    CONSTRAINT "flight_airplane_FK" FOREIGN KEY ("id_airplane") REFERENCES "AIRPLANE" ("id_airplane") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "flight_line_FK" FOREIGN KEY ("id_line") REFERENCES "LINE" ("id_line") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "flight_terminal_FK" FOREIGN KEY ("name_terminal") REFERENCES "TERMINAL" ("name_terminal") ON DELETE CASCADE ON UPDATE CASCADE
);
--ΓΡΑΜΜΗ
DROP TABLE IF EXISTS "LINE";
CREATE TABLE IF NOT EXISTS "LINE"(
    "id_line" integer NOT NULL,
    "date_line" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    PRIMARY KEY ("id_line")
 );
--ΑΕΡΟΠΛΑΝΟ
 DROP TABLE IF EXISTS "AIRPLANE";
 CREATE TABLE IF NOT EXISTS "AIRPLANE"(
    "id_airplane" varchar(15) NOT NULL,
    "name_airplane" varchar(20) NOT NULL,
    "seats" integer NOT NULL,
    "baggage" integer NOT NULL,
    "id_airline" integer NOT NULL,
    "name_category" varchar(30) NOT NULL,
    PRIMARY KEY("id_airplane"),
    CONSTRAINT "airplane_category_FK" FOREIGN KEY ("name_category") REFERENCES "CATEGORY" ("name_category") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "airplane_airline_FK" FOREIGN KEY ("id_airline") REFERENCES "AIRLINE" ("id_airline") ON DELETE CASCADE ON UPDATE CASCADE
 );
--ΚΑΤΗΓΟΡΙΑ
 DROP TABLE IF EXISTS "CATEGORY";
 CREATE TABLE IF NOT EXISTS "CATEGORY"(
     "name_category" varchar(30) NOT NULL,
    PRIMARY KEY("name_category")
 );
--ΑΕΡΟΠΟΡΙΚΗ ΕΤΑΙΡΙΑ
DROP TABLE IF EXISTS "AIRLINE";
CREATE TABLE IF NOT EXISTS "AIRLINE"(
    "id_airline" varchar(15) NOT NULL,
    "name_airline" varchar(50) NOT NULL,
    "email" varchar(50) NOT NULL,
    "country" varchar(20) NOT NULL,
    "town" varchar(20) NOT NULL,
    "web" varchar(90) NOT NULL,
    "phone" integer NOT NULL,
    PRIMARY KEY("id_airline")
);
 
 --CHECK-IN BOOTH
 DROP TABLE IF EXISTS "CHECKIN";
 CREATE TABLE IF NOT EXISTS "CHECKIN"(
    "number" integer NOT NULL,
    "open_date" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    "close_date" datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    "id_airline" integer NOT NULL,
    PRIMARY KEY("number"),
    CONSTRAINT "checkin_airline_FK" FOREIGN KEY ("id_airline") REFERENCES "AIRLINE" ("id_airline") ON DELETE CASCADE ON UPDATE CASCADE
 );

 --ΤΕΡΜΑΤΙΚΟΣ ΣΤΑΘΜΟΣ
 DROP TABLE IF EXISTS "TERMINAL";
 CREATE TABLE IF NOT EXISTS "TERMINAL"(
    "name_terminal" varchar(15) NOT NULL,
    PRIMARY KEY("name_terminal")
 );

 --ΠΥΛΗ
 DROP TABLE IF EXISTS "GATE";
 CREATE TABLE IF NOT EXISTS "GATE"(
    "name_gate" varchar(15) NOT NULL,
    "name_terminal" varchar(15) NOT NULL,
    PRIMARY KEY("name_gate"),
    CONSTRAINT "gate_terminal_FK" FOREIGN KEY ("name_terminal") REFERENCES "TERMINAL" ("name_terminal") ON DELETE CASCADE ON UPDATE CASCADE
 );

 --ΑΕΡΟΔΡΟΜΙΟ
 DROP TABLE IF EXISTS "AIRPORT";
 CREATE TABLE IF NOT EXISTS "AIRPORT"(
    "id_airport" integer NOT NULL,
    "name_airport" varchar(50) NOT NULL,
    "country" varchar(20) NOT NULL,
    "town" varchar(20) NOT NULL,
    PRIMARY KEY("id_airport")
 );


--ΑΕΡΟΠΟΡΙΚΗ ΕΤΑΙΡΙΑ
 INSERT INTO "AIRLINE" ("id_airline","name_airline","email","country","town","web","phone") VALUES 
 ('A3','AEGEAN','contact@aegeanair.com','ΕΛΛΑΔΑ','ΑΘΗΝΑ','www.aegeanair.com','8997594210'),
 ('AC','Air Canada','contact@aircanada.ca','ΚΑΝΑΔΑΣ','ΜΟΝΤΡΕΑΛ','www.aircanada.com','6927115111'),
 ('SM','Air Cairo','res.rm@flyaircairo.com','ΑΙΓΥΠΤΟΣ','ΚΑΊΡΟ','www.flyaircairo.com','0222687681'),
 ('AF','Air France','mail.meda@airfrance.fr','ΓΑΛΛΙΑ','ΠΑΡΙΣΙ','www.airfrance.com','6929993772'),
 ('BA','British Airways','contactbade@email.ba.com','ΗΝΩΜΕΝΟ ΒΑΣΙΛΕΙΟ','ΛΟΝΔΙΝΟ','www.britishairways.com','4215575758'),
 ('Az','ITA Airways','BookingsChangesRefunds@itaspa.com','ΙΤΑΛΙΑ','ΡΩΜΗ','www.itaspa.com','8003618336'),
 ('TK','Turkish Airlines','sales.muc@thy.com','ΤΟΥΡΚΙΑ','ΚΩΝΣΤΑΝΤΙΝΟΥΠΟΛΗ','www.turkishairlines.com','6986799849');

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
 CREATE TABLE IF NOT EXISTS "MID"(
     'id_aerodromio_mid' INTEGER NOT NULL,
     'id_grammi_mid' INTEGER NOT NULL,
     'ID_mid' INTEGER NOT NULL,
    PRIMARY KEY('ID_mid')
    CONSTRAINT "id_aerodromio_mid_FK" FOREIGN KEY ('id_aerodromio_mid') REFERENCES 'MID' ('id_aerodromio_mid') ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "id_grammi_mid_FK" FOREIGN KEY ('id_grammi_mid') REFERENCES 'MID' ('id_grammi_mid') ON DELETE CASCADE ON UPDATE CASCADE
 )