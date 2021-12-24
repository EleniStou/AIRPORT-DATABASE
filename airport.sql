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
-- ΠΡΟΟΡΙΣΜΟΣ 
DROP TABLE IF EXISTS "ARRIVAL";
CREATE TABLE IF NOT EXISTS "ARRIVAL"(
    "id_arrival" integer NOT NULL,
    "id_line" integer NOT NULL,
    "id_airport" integer NOT NULL,
    PRIMARY KEY("id_arrival")
    CONSTRAINT "arrival_airport_FK" FOREIGN KEY ("id_airport") REFERENCES "AIRPORT" ("id_airport") ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "arrival_line_FK" FOREIGN KEY ("line") REFERENCES "LINE" ("id_line") ON DELETE CASCADE ON UPDATE CASCADE
 ); 

 --ΑΦΙΞΗ 
DROP TABLE IF EXISTS "DEPARTURE";
CREATE TABLE IF NOT EXISTS "DEPARTURE"(
    "id_departure" integer NOT NULL,
    "id_line" integer NOT NULL,
    "id_airport" integer NOT NULL,
    PRIMARY KEY("id_departure")
    CONSTRAINT "departure_airport_FK" FOREIGN KEY ("id_airport") REFERENCES "AIRPORT" ("id_airport") ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "departure_line_FK" FOREIGN KEY ("line") REFERENCES "LINE" ("id_line") ON DELETE CASCADE ON UPDATE CASCADE
 ); 

 
 --ΕΝΔΙΑΜΕΣΟΣ ΣΤΑΘΜΟΣ
DROP TABLE IF EXISTS "MID";
CREATE TABLE IF NOT EXISTS "MID"(
    "id_mid" integer NOT NULL,
    "id_line" integer NOT NULL,
    "id_airport" integer NOT NULL,
    PRIMARY KEY("id_mid")
    CONSTRAINT "mid_airport_FK" FOREIGN KEY ("id_airport") REFERENCES "AIRPORT" ("id_airport") ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "mid_line_FK" FOREIGN KEY ("line") REFERENCES "LINE" ("id_line") ON DELETE CASCADE ON UPDATE CASCADE
 ); 


--ΔΕΔΟΜΕΝΑ ΑΕΡΟΠΟΡΙΚΗΣ ΕΤΑΙΡΙΑΣ
 INSERT INTO "AIRLINE" ("id_airline","name_airline","email","country","town","web","phone") VALUES 
 ('A3','AEGEAN','contact@aegeanair.com','ΕΛΛΑΔΑ','ΑΘΗΝΑ','www.aegeanair.com','8997594210'),
 ('AC','Air Canada','contact@aircanada.ca','ΚΑΝΑΔΑΣ','ΜΟΝΤΡΕΑΛ','www.aircanada.com','6927115111'),
 ('SM','Air Cairo','res.rm@flyaircairo.com','ΑΙΓΥΠΤΟΣ','ΚΑΊΡΟ','www.flyaircairo.com','2222687681'),
 ('AF','Air France','mail.meda@airfrance.fr','ΓΑΛΛΙΑ','ΠΑΡΙΣΙ','www.airfrance.com','6929993772'),
 ('BA','British Airways','contactbade@email.ba.com','ΗΝΩΜΕΝΟ ΒΑΣΙΛΕΙΟ','ΛΟΝΔΙΝΟ','www.britishairways.com','4215575758'),
 ('AZ','ITA Airways','BookingsChangesRefunds@itaspa.com','ΙΤΑΛΙΑ','ΡΩΜΗ','www.itaspa.com','8003618336'),
 ('TK','Turkish Airlines','sales.muc@thy.com','ΤΟΥΡΚΙΑ','ΚΩΝΣΤΑΝΤΙΝΟΥΠΟΛΗ','www.turkishairlines.com','6986799849')
 ('AA','American Airlines','contact@americanair.com','ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ','ΤΕΞΑΣ','www.americanairlines.com','6929993234')

 ;

