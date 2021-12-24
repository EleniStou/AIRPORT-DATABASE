BEGIN TRANSACTION;
--ΠΤΗΣΗ
DROP TABLE IF EXISTS "FLIGHT";
CREATE TABLE IF NOT EXISTS "FLIGHT"(
    "id_flight" integer NOT NULL,
    "id_airplane" integer NOT NULL,
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
    "id_airplane" integer NOT NULL,
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
 ('AMA','American Airlines','contact@americanair.com','ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ ΑΜΕΡΙΚΗΣ','ΤΕΞΑΣ','www.americanairlines.com','6929993234'),
 ('ASL','ASL Airlines Ireland','contact@ireland.com','ΙΡΛΑΝΔΙΑ','ΔΟΥΒΛΙΝΟ','www.aslairlines.ie','3849726345'),
 ('BRA','British Airways','contactbade@email.ba.com','ΗΝΩΜΕΝΟ ΒΑΣΙΛΕΙΟ','ΛΟΝΔΙΝΟ','www.britishairways.com','4215575758'),
 ('EMI','Emirates','contact@emirates.com','ΗΝΩΜΕΝΑ ΑΡΑΒΙΚΑ ΕΜΙΡΑΤΑ','ΝΤΟΥΜΠΑΙ','www.emirates.com','6945192000'),
 ('EUW','Eurowings','contact@eurowings.com','ΓΕΡΜΑΝΙΑ','ΝΤΙΣΕΛΝΤΟΡΦ','www.eurowings.com','2159988222'),
 ('IBE','Iberia','contact@iberia.com','ΙΣΠΑΝΙΑ','ΜΑΔΡΙΤΗ','www.iberia.com','6950073874'),
 ('ITA','ITA Airways','BookingsChangesRefunds@itaspa.com','ΙΤΑΛΙΑ','ΡΩΜΗ','www.itaspa.com','8003618336'),
 ('KLM','KLM','contact@klm.com','ΟΛΛΑΝΔΙΑ','ΑΜΣΤΕΡΝΤΑΜ','www.klm.com','6929993770'),
 ('LOT','LOT','service@lot.pl','ΠΟΛΩΝΕΙΑ','ΒΑΡΣΟΒΙΑ','www.lot.com','6915325324'),
 ('LUX','Luxair','group@luxairgroup.lu','ΛΟΥΞΕΜΒΟΥΡΓΟ','ΛΟΥΞΕΜΒΟΥΡΓΟ','www.luxair.lu','3522456123'),
 ('MAL','Malta MedAir','contact@malta.com','ΜΑΛΤΑ','ΒΑΛΕΤΑ','www.maltamedair.com','5621223355'),
 ('NOW','Norwegian','grupper@norwegian.no','ΝΟΡΒΗΓΙΑ','ΟΣΛΟ','www.norwegian.com','8005895000'),
 ('QAN','QANTAS','contact@qantas.com','ΑΥΣΤΡΑΛΙΑ','ΣΙΔΝΕΪ','www.qantas.com','1300655234'),
 ('SIN','Singapore Airlines','de.feedback@singaporeair.com.sg','ΣΙΓΚΑΠΟΥΡΗ','ΣΙΓΚΑΠΟΥΡΗ','www.singaporeair.com','6917415659'),
 ('SWI','SWISS','contact.@swiss.com','ΣΟΥΗΔΙΑ','ΣΤΟΚΧΟΛΜΗ','www.swiss.com','6986798000'),
 ('TAP','TAP Air Portugal','contact@tap.com','ΠΟΡΤΟΓΑΛΙΑ','ΛΙΣΑΒΟΝΑ','www.flytap.com','8009311821'),
 ('THA','Thai Airways International','muc@thai-airways.de','ΤΑΪΛΑΝΔΗ','ΜΠΑΝΓΚΟΚ','www.thaiairways.com','8924207010'),
 ('TRA','Trade Air','sales@trade-air.com','ΚΡΟΑΤΙΑ','ΖΑΓΚΡΕΜΠ','www.trade-air.com','8516265156'),
 ('TUA','Turkish Airlines','sales.muc@thy.com','ΤΟΥΡΚΙΑ','ΚΩΝΣΤΑΝΤΙΝΟΥΠΟΛΗ','www.turkishairlines.com','6986799849'),
 ('TUN','Tunisair','muenchen@tunisair.de','ΤΥΝΗΣΙΑ','ΤΥΝΙΔΑ','www.tunisair.com.tn','6927100110'),
 ('UIA','UIA','uia@goldstar.gr','ΟΥΚΡΑΝΙΑ','ΚΙΕΒΟ','www.flyuia.com','2111003080'),
 ('UNI','United','contact@united.com','ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ ΑΜΕΡΙΚΗΣ','ΣΙΚΑΓΟ','www.united.com','6950985051'),
 ('VUE','Vueling','vuelingpass@gistc.es','ΙΣΠΑΝΙΑ','ΒΑΡΚΕΛΩΝΗ','www.vueling.com','8009277989');

--ΔΕΔΟΜΕΝΑ ΑΕΡΟΠΛΑΝΟΥ
INSERT INTO "AIRPLANE"("id_airplane","name_airplane","seats","baggage","id_airline","name_category") VALUES
(1001,'Airbus A319',144,5500,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1002,'Airbus A320neo',180,5500,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1003,'Airbus A320',174,5500,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1004,'Airbus A321neo',220,9000,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1005,'Airbus A321',206,9000,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1006,'Airbus A321',206,9000,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1007,'Dash 8-Q400',78,4500,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1008,'Dash 8-Q400',78,4500,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1009,'Dash 8-100',37,6470,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1010,'ATR 42-600',48,8600,'AEG','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1011,'Airbus A320',174,5500,'AER','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1012,'Airbus A320',174,5500,'AER','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1013,'Airbus A321',206,9000,'AER','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1014,'Airbus A321',206,9000,'AER','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1015,'Boeing 777-300ER',402,12000,'AER','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1016,'Boeing 777-300ER',402,12000,'AER','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1017,'Irkut MC-21-300',175,5500,'AER','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1018,'Airbus A320',174,5500,'AIA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1019,'Airbus A321neo',220,9000,'AIA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1020,'Airbus A321neo',220,9000,'AIA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1021,'Boeing 787-9',298,9000,'AIC','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1022,'Boeing 787-9',298,9000,'AIC','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1023,'Boeing 737',200,8000,'AIC','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1024,'Airbus A320',174,5500,'AIC','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1025,'Airbus A321',206,9000,'AIC','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1026,'Airbus A321',206,9000,'AIF','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1027,'Airbus A320',174,5500,'AIF','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1028,'Boeing 777-300ER',402,12000,'AIF','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1029,'Boeing 777-300ER',402,12000,'AIF','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1030,'Boeing 777-300ER',402,12000,'AMA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1031,'Boeing 777-300ER',402,12000,'AMA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1032,'Airbus A319',128,5000,'AMA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1033,'Airbus A319',128,5000,'AMA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1034,'Airbus A321',206,9000,'AMA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1035,'Airbus A321',206,9000,'AMA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1036,'Airbus A321neo',220,9000,'AMA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1037,'Airbus A321neo',220,9000,'AMA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1038,'Boeing 737',200,8000,'ASL','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1039,'Boeing 737',0,8000,'ASL','ΒΙΟΜΗΧΑΝΙΚΩΝ ΜΕΤΑΦΟΡΩΝ'),
(1040,'Airbus A320',174,5500,'BRA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1041,'Airbus A320',174,5500,'BRA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1042,'Airbus A321',206,9000,'BRA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1043,'Airbus A321',206,9000,'BRA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1044,'Airbus A321neo',220,'9000','BRA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1045,'Airbus A321neo',220,'9000','BRA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1046,'Airbus A380',500,16000,'EMI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1047,'Airbus A380',500,16000,'EMI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1048,'Boeing 777-300ER',402,12000,'EMI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1049,'Boeing 777-300ER',402,12000,'EMI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1050,'Airbus A319',128,5000,'EUW','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1051,'Airbus A320',174,5500,'EUW','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1052,'Airbus A330',310,9000,'EUW','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1053,'Airbus A330',310,9000,'IBE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1054,'Airbus A330',310,9000,'IBE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1055,'Airbus A319',128,5000,'IBE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1056,'Airbus A321',206,9000,'IBE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1057,'Airbus A321neo',220,'9000','IBE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1058,'Airbus A320',174,5500,'IBE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1059,'Airbus A321neo',220,9000,'IBE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1060,'Airbus A320',174,5500,'ITA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1061,'Airbus A321',206,9000,'ITA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1062,'Airbus A321',206,9000,'ITA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1063,'Airbus A321neo',220,9000,'ITA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1064,'Boeing 777-300ER',402,12000,'ITA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1065,'Boeing 777-300ER',402,12000,'ITA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1066,'Boeing 777-300ER',402,12000,'KLM','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1067,'Boeing 737',200,8000,'KLM','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1068,'Airbus A321',206,9000,'KLM','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1069,'Boeing 737',200,8000,'LOT','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1070,'Embraer 175',78,4500,'LOT','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1071,'Boeing 737',200,8000,'LUX','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1072,'Embraer 175',78,4500,'LUX','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1073,'Airbus A320',174,5500,'MAL','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1074,'Boeing 737',200,8000,'NOW','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1075,'Boeing 737',200,8000,'NOW','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1076,'Boeing 737',200,8000,'QAN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1077,'Boeing 737',200,8000,'QAN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1078,'Boeing 747',402,12000,'QAN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1079,'Boeing 747',402,12000,'QAN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1080,'Airbus A330',310,9000,'SIN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1081,'Airbus A330',310,9000,'SIN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1082,'Boeing 777-300ER',402,12000,'SIN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1083,'Airbus A319',128,5000,'SWI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1084,'Airbus A320',174,5500,'SWI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1085,'Airbus A320',174,5500,'SWI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1086,'Airbus A321',206,9000,'SWI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1087,'Airbus A321',206,9000,'SWI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1088,'Boeing 777-300ER',402,12000,'SWI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1089,'Boeing 777-300ER',402,12000,'SWI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1090,'Airbus A319',128,5000,'TAP','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1091,'Airbus A320',174,5500,'TAP','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1092,'Airbus A320',174,5500,'TAP','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1093,'Airbus A321neo',220,'9000','TAP','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1094,'Airbus A321',206,9000,'TAP','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1095,'Airbus A330',310,9000,'TAP','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1096,'Boeing 777-300ER',402,12000,'THA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1097,'Boeing 777-300ER',402,12000,'THA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1098,'Airbus A320',174,5500,'TRA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1099,'Airbus A319',128,5000,'TRA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1100,'Airbus A321',206,9000,'TUA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1101,'Airbus A321',206,9000,'TUA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1102,'Airbus A330',310,9000,'TUA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1103,'Boeing 737',200,8000,'TUA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1104,'Boeing 737',200,8000,'TUA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1105,'Boeing 777-300ER',402,12000,'TUA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1106,'Airbus A330',0,15000,'TUA','ΒΙΟΜΗΧΑΝΙΚΩΝ ΜΕΤΑΦΟΡΩΝ'),
(1107,'Boeing 747',0,15000,'TUA','ΒΙΟΜΗΧΑΝΙΚΩΝ ΜΕΤΑΦΟΡΩΝ'),
(1108,'Airbus A320',174,5500,'TUN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1109,'Boeing 737',200,8000,'TUN','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1110,'Boeing 737',200,8000,'UIA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1111,'Embraer 175',78,4500,'UIA','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1112,'Boeing 787-9',298,9000,'UNI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1113,'Boeing 787-9',298,9000,'UNI','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1114,'Airbus A320',174,5500,'VUE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),
(1115,'Airbus A320',174,5500,'VUE','ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ');


--ΔΕΔΟΜΕΝΑ ΚΑΤΗΓΟΡΙΑΣ
INSERT INTO "CATEGORY" ("name_category") VALUES ('ΕΜΠΟΡΙΚΗΣ ΜΕΤΑΦΟΡΑΣ'),('ΒΙΟΜΗΧΑΝΙΚΩΝ ΜΕΤΑΦΟΡΩΝ');

--ΔΕΔΟΜΕΝΑ ΑΕΡΟΔΡΟΜΙΟΥ
 INSERT INTO "AIRPORT" ("id_airport", "name_airport", "country", "town") VALUES
 (03527, 'ATHENS INTERNATIONAL AIRPORT ELEFTHERIOS VENIZELOS', 'ΕΛΛΑΔΑ', 'ΑΘΗΝΑ'),
 (16935, 'Montréal-Pierre Elliott Trudeau International Airport', 'ΚΑΝΑΔΑΣ', 'ΜΟΝΤΡΕΑΛ'),
 (17543, 'Thessaloniki Airport Makedonia', 'ΕΛΛΑΔΑ', 'ΘΕΣΣΑΛΟΝΙΚΗ'),
 (19065,'Singapore Changi Airport', 'ΣΙΓΚΑΠΟΥΡΗ', 'ΣΙΓΚΑΠΟΥΡΗ'),
 (20674, 'Malta International Airport', 'ΜΑΛΤΑ', 'ΒΑΛΕΤΑ'),
 (21896, 'Sheremetyevo - A.S. Pushkin international airport', 'ΡΩΣΙΑ', 'ΜΟΣΧΑ'),
 (22874, 'OSLO AIRPORT', 'ΝΟΡΒΗΓΙΑ', 'ΌΣΛΟ'),
 (25904, 'Boryspil International Airport', 'ΟΥΚΡΑΝΙΑ','ΚΙΕΒΟ'),
 (26985, 'Stockholm Arlanda Airport', 'ΣΟΥΗΔΙΑ', 'ΣΤΟΚΧΟΛΜΗ'),
 (27290, 'Dubai International Airport', 'ΗΝΩΜΕΝΑ ΑΡΑΒΙΚΑ ΕΜΙΡΑΤΑ','ΝΤΟΥΜΠΑΙ'),
 (27342, 'Cairo International Airport', 'ΑΙΓΥΠΤΟΣ', 'ΚΑΙΡΟ'),
 (28567, 'Kirov Airport', 'ΡΩΣΣΙΑ', 'ΚΙΡΟΦ'),
 (28790, 'Kiruna Airport', 'ΣΟΥΗΔΙΑ', 'ΚΙΡΟΥΝΑ'),
 (29856, 'Dublin Airport', 'ΙΡΛΑΝΔΙΑ','ΔΟΥΒΛΙΝΟ'),
 (30689, " O'Hare International Airport", 'ΣΙΚΑΓΟ', 'ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ'),
 (31673, 'Suvarnabhumi Airport', 'ΤΑΪΛΑΝΔΗ','ΜΠΑΝΓΚΟΚ'),
 (32895, 'WARSAW CHOPIN AIRPORT', 'ΠΟΛΩΝΙΑ','ΒΑΡΣΟΒΙΑ'),
 (33745, 'Sydney Airport', 'ΑΥΣΤΡΑΛΙΑ', 'ΣΙΔΝΕΥ'),
 (34869, 'DUSSELDORF AIRPORT', 'ΓΕΡΜΑΝΙΑ','ΝΤΙΣΕΛΝΤΟΡΦ'),
 (35690, 'LISBON AIRPORT', 'ΛΙΣΑΒΟΝΑ', 'ΙΣΠΑΝΙΑ'),
 (36490, 'Amsterdam Airport Schiphol', 'ΟΛΑΝΔΙΑ', 'ΑΜΣΤΕΡΝΤΑΜ'),
 (37890, 'Luxembourg Airport', 'ΛΟΥΞΕΜΒΟΥΡΓΟ','ΛΟΥΞΕΜΒΟΥΡΓΟ'),
 (38765, 'Tunis–Carthage International Airport', 'ΤΥΝΗΣΙΑ','ΤΥΝΙΔΑ'),
 (45970, 'BARCELONA AIRPORT', 'ΙΣΠΑΝΙΑ', 'ΒΑΡΚΕΛΩΝΗ'),
 (47860, 'Adolfo Suárez Madrid–Barajas Airport', 'ΙΣΠΑΝΙΑ', 'ΜΑΔΡΙΤΗ'),
 (48769, 'Franjo Tuđman Airport Zagreb', 'ΚΡΟΑΤΙΑ','ΖΑΓΚΡΕΜΠ'),
 (49028, 'Paris Charles de Gaulle Airport', 'ΓΑΛΛΙΑ', 'ΠΑΡΙΣΙ'),
 (50276, 'London International Airport', 'ΗΝΩΜΕΝΟ ΒΑΣΙΛΕΙΟ', 'ΛΟΝΔΙΝΟ'),
 (54870, 'Antalya Airport', 'ΤΟΥΡΚΙΑ', 'ΑΤΤΑΛΕΙΑ'),
 (58769, 'Giuseppe Verdi Airport', 'ΙΤΑΛΙΑ', 'ΠΑΡΜΑ'),
 (59876, 'Odesa International Airport', 'ΟΥΚΡΑΝΙΑ','ΟΔΥΣΣΟΣ'),
 (66319, 'Leonardo da Vinci International Airport', 'ΙΤΑΛΙΑ', 'ΡΩΜΗ'),
 (80956, 'Istanbul Airport', 'ΤΟΥΡΚΙΑ', 'ΚΩΝΣΤΝΤΙΝΟΥΠΟΛΗ'),
 (99362, 'Dallas/Fort Worth International Airport', 'ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ', 'ΤΕΞΑΣ');

