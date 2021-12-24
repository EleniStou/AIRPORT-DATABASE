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
    PRIMARY KEY("id_arrival"),
    CONSTRAINT "arrival_airport_FK" FOREIGN KEY ("id_airport") REFERENCES "AIRPORT" ("id_airport") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "arrival_line_FK" FOREIGN KEY ("id_line") REFERENCES "LINE" ("id_line") ON DELETE CASCADE ON UPDATE CASCADE
 ); 

 --ΑΦΙΞΗ 
DROP TABLE IF EXISTS "DEPARTURE";
CREATE TABLE IF NOT EXISTS "DEPARTURE"(
    "id_departure" integer NOT NULL,
    "id_line" integer NOT NULL,
    "id_airport" integer NOT NULL,
    PRIMARY KEY("id_departure"),
    CONSTRAINT "departure_airport_FK" FOREIGN KEY ("id_airport") REFERENCES "AIRPORT" ("id_airport") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "departure_line_FK" FOREIGN KEY ("id_line") REFERENCES "LINE" ("id_line") ON DELETE CASCADE ON UPDATE CASCADE
 ); 

 
 --ΕΝΔΙΑΜΕΣΟΣ ΣΤΑΘΜΟΣ
DROP TABLE IF EXISTS "MID";
CREATE TABLE IF NOT EXISTS "MID"(
    "id_mid" integer NOT NULL,
    "id_line" integer NOT NULL,
    "id_airport" integer NOT NULL,
    PRIMARY KEY("id_mid"),
    CONSTRAINT "mid_airport_FK" FOREIGN KEY ("id_airport") REFERENCES "AIRPORT" ("id_airport") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "mid_line_FK" FOREIGN KEY ("id_line") REFERENCES "LINE" ("id_line") ON DELETE CASCADE ON UPDATE CASCADE
 ); 


--ΔΕΔΟΜΕΝΑ ΑΕΡΟΠΟΡΙΚΗΣ ΕΤΑΙΡΙΑΣ
 INSERT INTO "AIRLINE" ("id_airline","name_airline","email","country","town","web","phone") VALUES 
 ('AEG','AEGEAN','contact@aegeanair.com','ΕΛΛΑΔΑ','ΑΘΗΝΑ','www.aegeanair.com','8997594210'),
 ('AER','Aeroflot','munich@aeroflot.de','ΡΩΣΙΑ','ΜΟΣΧΑ','www.aeroflot.ru','8000001151'),
 ('AIA','Air Cairo','res.rm@flyaircairo.com','ΑΙΓΥΠΤΟΣ','ΚΑΪΡΟ','www.flyaircairo.com','2222687681'),
 ('AIC','Air Canada','contact@aircanada.ca','ΚΑΝΑΔΑΣ','ΜΟΝΤΡΕΑΛ','www.aircanada.com','6927115111'),
 ('AIF','Air France','mail.meda@airfrance.fr','ΓΑΛΛΙΑ','ΠΑΡΙΣΙ','www.airfrance.com','6929993772'),
 ('AMA','American Airlines','contact@americanair.com','ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ','ΤΕΞΑΣ','www.americanairlines.com','6929993234'),
 ('BRA','British Airways','contactbade@email.ba.com','ΗΝΩΜΕΝΟ ΒΑΣΙΛΕΙΟ','ΛΟΝΔΙΝΟ','www.britishairways.com','4215575758'),
 ('EMI','Emirates','contact@emirates.com','ΗΝΩΜΕΝΑ ΑΡΑΒΙΚΑ ΕΜΙΡΑΤΑ','ΝΤΟΥΜΠΑΙ','www.emirates.com','6945192000'),
 ('EUW','Eurowings','contact@eurowings.com','ΓΕΡΜΑΝΙΑ','ΝΤΙΣΕΛΝΤΟΡΦ','www.eurowings.com','2159988222'),
 ('IBE','Iberia','contact@iberia.com','ΙΣΠΑΝΙΑ','ΜΑΔΡΙΤΗ','www.iberia.com','6950073874'),
 ('ITA','ITA Airways','BookingsChangesRefunds@itaspa.com','ΙΤΑΛΙΑ','ΡΩΜΗ','www.itaspa.com','8003618336'),
 ('KLM','KLM','contact@klm.com','ΟΛΛΑΝΔΙΑ','ΑΜΣΤΕΡΝΤΑΜ','www.klm.com','6929993770'),
 ('LOT','LOT','service@lot.pl','ΠΟΛΩΝΕΙΑ','ΒΑΡΣΟΒΙΑ','www.lot.com','6915325324'),
 ('LUX','Luxair','group@luxairgroup.lu','ΛΟΥΞΕΜΒΟΥΡΓΟ','ΛΟΥΞΕΜΒΟΥΡΓΟ','www.luxair.lu','3522456123'),
 ('NOW','Norwegian','grupper@norwegian.no','ΝΟΡΒΗΓΙΑ','ΟΣΛΟ','www.norwegian.com','8005895000'),
 ('SIQ','Singapore Airlines','de.feedback@singaporeair.com.sg','ΣΙΓΚΑΠΟΥΡΗ','ΣΙΓΚΑΠΟΥΡΗ','www.singaporeair.com','6917415659'),
 ('SWI','SWISS','contact.@swiss.com','ΣΟΥΗΔΙΑ','ΣΤΟΚΧΟΛΜΗ','www.swiss.com','6986798000'),
 ('TAP','TAP Air Portugal','contact@tap.com','ΠΟΡΤΟΓΑΛΙΑ','ΛΙΣΑΒΟΝΑ','www.flytap.com','8009311821'),
 ('THA','Thai Airways International','muc@thai-airways.de','ΤΑΪΛΑΝΔΗ','ΜΠΑΝΓΚΟΚ','www.thaiairways.com','8924207010'),
 ('TUA','Turkish Airlines','sales.muc@thy.com','ΤΟΥΡΚΙΑ','ΚΩΝΣΤΑΝΤΙΝΟΥΠΟΛΗ','www.turkishairlines.com','6986799849')
 ;

--ΔΕΔΟΜΕΝΑ ΑΕΡΟΔΡΟΜΙΟΥ
 INSERT INTO "AIRPORT" ("id_airport", "name_airport", "country", "town") VALUES
 ('03527','ATHENS INTERNATIONAL AIRPORT ELEFTHERIOS VENIZELOS','ΕΛΛΑΔΑ','ΑΘΗΝΑ'),
 ('23894','Montréal-Pierre Elliott Trudeau International Airport','ΚΑΝΑΔΑΣ','ΜΟΝΤΡΕΑΛ'),
 ('64273','Cairo International Airport','ΑΙΓΥΠΤΟΣ','ΚΑΙΡΟ'),
 ('16935','Paris Charles de Gaulle Airport','ΓΑΛΛΙΑ','ΠΑΡΙΣΙ'),
 ('72590','London International Airport','ΗΝΩΜΕΝΟ ΒΑΣΙΛΕΙΟ','ΛΟΝΔΙΝΟ'),
 ('30816','Leonardo da Vinci International Airport','ΙΤΑΛΙΑ','ΡΩΜΗ'),
 ('42693','Istanbul Airport','ΤΟΥΡΚΙΑ','ΚΩΝΣΤΝΤΙΝΟΥΠΟΛΗ'),
 ('51830','Dallas/Fort Worth International Airport','ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ','ΤΕΞΑΣ');