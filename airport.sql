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
    "day_line" varchar(10) NOT NULL,
    "time_line" time NOT NULL DEFAULT '00:00:00',
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
    "number" varchar(10) NOT NULL,
    "open_time" time NOT NULL DEFAULT '00:00:00',
    "close_time" datetime NOT NULL DEFAULT '00:00:00',
    "id_airline" integer NOT NULL,
    "id_line" integer NOT NULL,
    PRIMARY KEY("id_line"),
    CONSTRAINT "checkin_airline_FK" FOREIGN KEY ("id_airline") REFERENCES "AIRLINE" ("id_airline") ON DELETE CASCADE ON UPDATE CASCADE
    CONSTRAINT "checkin_line_FK" FOREIGN KEY ("id_line") REFERENCES "LINE" ("id_line")  ON DELETE CASCADE ON UPDATE CASCADE
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

 --ΑΦΙΞΗ  
DROP TABLE IF EXISTS "ARRIVAL";
CREATE TABLE IF NOT EXISTS "ARRIVAL"(
    "id_arrival" integer NOT NULL,
    "id_line" integer NOT NULL,
    "id_airport" integer NOT NULL,
    PRIMARY KEY("id_arrival"),
    CONSTRAINT "arrival_airport_FK" FOREIGN KEY ("id_airport") REFERENCES "AIRPORT" ("id_airport") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "arrival_line_FK" FOREIGN KEY ("id_line") REFERENCES "LINE" ("id_line") ON DELETE CASCADE ON UPDATE CASCADE
 ); 

-- ΠΡΟΟΡΙΣΜΟΣ
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


--ΔΕΔΟΜΕΝΑ ΤΕΡΜΑΤΙΚΟΥ ΣΤΑΘΜΟΥ
INSERT INTO "TERMINAL"("name_terminal") VALUES
('Terminal A'),('Terminal B'),('Terminal C'),('Terminal D'),('Terminal E'),('Terminal F');

--ΔΕΔΟΜΕΝΑ ΠΥΛΗΣ
INSERT INTO "GATE"('name_gate','name_terminal') VALUES
('A1', 'Terminal A'), ('A2', 'Terminal A'), ('A3', 'Terminal A'), 
('B1', 'Terminal B'), ('B2', 'Terminal B'), ('B3', 'Terminal B'),
('C1', 'Terminal C'), ('C2', 'Terminal C'), ('C3', 'Terminal C'),
('D1', 'Terminal D'), ('D2', 'Terminal D'), ('D3', 'Terminal D'),
('E1', 'Terminal E'), ('E2', 'Terminal E'), ('E3', 'Terminal E'),
('F1', 'Terminal F'), ('F2', 'Terminal F'), ('F3', 'Terminal F');

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
 (28567, 'Kirov Airport', 'ΡΩΣΙΑ', 'ΚΙΡΟΦ'),
 (28790, 'Kiruna Airport', 'ΣΟΥΗΔΙΑ', 'ΚΙΡΟΥΝΑ'),
 (29856, 'Dublin Airport', 'ΙΡΛΑΝΔΙΑ','ΔΟΥΒΛΙΝΟ'),
 (30689, "O'Hare International Airport", 'ΣΙΚΑΓΟ', 'ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ'),
 (31673, 'Suvarnabhumi Airport', 'ΤΑΪΛΑΝΔΗ','ΜΠΑΝΓΚΟΚ'),
 (32895, 'WARSAW CHOPIN AIRPORT', 'ΠΟΛΩΝΙΑ','ΒΑΡΣΟΒΙΑ'),
 (33745, 'Sydney Airport', 'ΑΥΣΤΡΑΛΙΑ', 'ΣΙΔΝΕΥ'),
 (34869, 'DUSSELDORF AIRPORT', 'ΓΕΡΜΑΝΙΑ','ΝΤΙΣΕΛΝΤΟΡΦ'),
 (35690, 'LISBON AIRPORT', 'ΛΙΣΑΒΟΝΑ', 'ΠΟΡΤΟΓΑΛΙΑ'),
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
 (80956, 'Istanbul Airport', 'ΤΟΥΡΚΙΑ', 'ΚΩΝΣΤΑΝΤΙΝΟΥΠΟΛΗ'),
 (99362, 'Dallas/Fort Worth International Airport', 'ΗΝΩΜΕΝΕΣ ΠΟΛΙΤΕΙΕΣ', 'ΤΕΞΑΣ'),
 (99654, 'Amsterdam Airport Schiphol','ΟΛΛΑΝΔΙΑ','ΑΜΣΤΕΡΝΤΑΜ');

-- ΔΕΔΟΜΕΝΑ ΠΤΗΣΗΣ
INSERT INTO "FLIGHT"("id_flight","id_airplane","date_flight","id_line","name_terminal") VALUES
(135, 1006, '2021-01-05 07:35:00', 001, 'Terminal A'),
(157, 1011, '2021-01-05 21:45:00', 002, 'Terminal B'),
(165, 1019, '2021-01-05 22:20:00', 003, 'Terminal A'),
(170, 1022, '2021-01-06 03:15:00', 004, 'Terminal A'),
(175, 1025, '2021-01-06 14:50:00', 005, 'Terminal C'),
(180, 1030, '2021-01-06 18:10:00', 006, 'Terminal B'),
(186, 1038, '2021-01-06 22:15:00', 007, 'Terminal B'),
(188, 1046, '2021-01-07 02:00:00', 008, 'Terminal A'),
(190, 1053, '2021-01-07 07:20:00', 009, 'Terminal C'),
(195, 1059, '2021-01-07 07:25:00', 010, 'Terminal C'),
(200, 1064, '2021-01-07 08:05:00', 011, 'Terminal B'),
(205, 1067, '2021-01-07 11:05:00', 012, 'Terminal D'),
(210, 1082, '2021-01-07 11:43:00', 013, 'Terminal E'),
(212, 1095, '2021-01-08 11:15:00', 014, 'Terminal F'),
(270, 1103, '2021-01-08 13:50:00', 015, 'Terminal C'),
(278, 1107, '2021-01-08 15:10:00', 016, 'Terminal D'),
(294, 1115, '2021-01-08 16:20:00', 017, 'Terminal E'),
(293, 1001, '2021-01-08 18:20:00', 018, 'Terminal F'),
(300, 1008, '2021-01-09 00:05:00', 019, 'Terminal C'),
(323, 1017, '2021-01-09 10:40:00', 020, 'Terminal D'),
(345, 1033, '2021-01-09 10:50:00', 021, 'Terminal A'),
(400, 1040, '2021-01-09 15:10:00', 022, 'Terminal D'),
(412, 1048, '2021-01-09 22:50:00', 023, 'Terminal A'),
(443, 1050, '2021-01-10 00:35:00', 024, 'Terminal F'),
(450, 1055, '2021-01-10 01:33:00', 025, 'Terminal E'),
(467, 1111, '2021-01-10 05:25:00', 026, 'Terminal C'),
(490, 1114, '2021-01-10 10:20:00', 027, 'Terminal B'),
(500, 1070, '2021-01-10 18:45:00', 028, 'Terminal A'),
(546, 1080, '2021-01-10 19:50:00', 029, 'Terminal E'),
(576, 1065, '2021-01-10 20:00:00', 030, 'Terminal F'),
(598, 1093, '2021-01-10 22:40:00', 031, 'Terminal D');


--ΔΕΔΟΜΕΝΑ ΓΡΑΜΜΗΣ
INSERT INTO "LINE" ("id_line", "day_line","time_line") VALUES
(001, 'ΔΕΥΤΕΡΑ', '07:35:00'),--ΕΛΛΑΔΑ
(002, 'ΔΕΥΤΕΡΑ', '21:40:00'),--ΡΩΣΙΑ
(003, 'ΔΕΥΤΕΡΑ','22:20:00'),--ΑΙΓΥΠΤΟΣ
(004, 'ΤΡΙΡΗ', '03:15:00'),--ΚΑΝΑΔΑΣ
(005, 'ΤΡΙΡΗ', '14:40:00'),--ΚΑΝΑΔΑΣ
(006, 'ΤΡΙΤΗ', '18:10:00'),--ΗΠΑ/ΤΕΞΑΣ
(007, 'ΤΡΙΤΗ', '22:10:00'),--ΙΡΛΑΝΔΙΑ
(008, 'ΤΕΤΑΡΤΗ', '02:00:00'),--ΝΤΟΥΜΠΑΙ
(009, 'ΤΕΤΑΡΤΗ', '07:20:00'),--ΙΣΠΑΝΙΑ
(010, 'ΤΕΤΑΡΤΗ', '07:25:00'),--ΙΣΠΑΝΙΑ
(011, 'ΤΕΤΑΡΤΗ', '07:50:00'),--ΙΤΑΛΙΑ
(012, 'ΤΕΤΑΡΤΗ', '11:05:00'),--ΟΛΛΑΝΔΙΑ
(013, 'ΤΕΤΑΡΤΗ', '11:10:00'),--ΣΙΓΚΑΠΟΥΡΗ
(014, 'ΠΕΜΠΤΗ', '11:15:00'),--ΠΟΡΤΟΓΑΛΙΑ
(015, 'ΠΕΜΠΤΗ', '13:40:00'),--ΤΟΥΡΚΙΑ/ΚΩΝΣΤΑΝΤΙΝΟΥΠΟΛΗ
(016, 'ΠΕΜΠΤΗ', '15:10:00'),--ΤΟΥΡΚΙΑ/ΚΩΝΣΤΑΝΤΙΝΟΥΠΟΛΗ
(017, 'ΠΕΜΠΤΗ', '16:10:00'),--ΙΣΠΑΝΙΑ/ΒΑΡΚΕΛΩΝΗ
(018, 'ΠΕΜΠΤΗ', '18:20:00'),--ΕΛΛΑΔΑ
(019, 'ΠΑΡΑΣΚΕΥΗ', '00:05:00'),--ΕΛΛΑΔΑ
(020, 'ΠΑΡΑΣΚΕΥΗ', '10:40:00'),--ΡΩΣΙΑ
(021, 'ΠΑΡΑΣΚΕΥΗ', '10:50:00'),--ΗΠΑ/ΤΕΞΑΣ
(022, 'ΠΑΡΑΣΚΕΥΗ', '15:00:00'),--ΗΝΩΜ.ΒΑΣΙΛΕΙΟ
(023, 'ΠΑΡΑΣΚΕΥΗ', '22:50:00'),--ΝΤΟΥΜΠΑΙ
(024, 'ΣΑΒΒΑΤΟ', '00:35:00'),--ΓΕΡΜΑΝΙΑ
(025, 'ΣΑΒΒΑΤΟ', '01:33:00'),--ΙΣΠΑΝΙΑ
(026, 'ΣΑΒΒΑΤΟ', '05:20:00'),--ΟΥΚΡΑΝΙΑ
(027, 'ΣΑΒΒΑΤΟ', '10:20:00'),--ΙΣΠΑΝΙΑ/ΒΑΡΚΕΛΩΝΗ
(028, 'ΣΑΒΒΑΤΟ', '18:40:00'),--ΠΟΛΩΝΙΑ
(029, 'ΣΑΒΒΑΤΟ', '19:50:00'),--ΣΙΓΚΑΠΟΥΡΗ
(030, 'ΣΑΒΒΑΤΟ', '20:00:00'),--ΙΤΑΛΙΑ
(031, 'ΣΑΒΒΑΤΟ', '22:40:00');--ΠΟΡΤΟΓΑΛΙΑ

--ΔΕΔΟΜΕΝΑ ΠΡΟΟΡΙΣΜΟΥ
INSERT INTO "DEPARTURE"("id_departure","id_line","id_airport") VALUES
(2001,001,03527),
(2002,002,21896),
(2003,004,16935),
(2004,006,99362),
(2005,008,27290),
(2006,009,47860),
(2007,011,58769),
(2008,014,35690),
(2009,015,80956),
(2010,019,17543),
(2011,020,28567),
(2012,022,50276),
(2013,024,34869),
(2014,025,47860),
(2015,027,45970),
(2016,029,59876);

--ΔΕΔΟΜΕΝΑ ΑΦΙΞΗΣ
INSERT INTO "ARRIVAL"("id_arrival","id_line","id_airport") VALUES
(3001,003,27342),
(3002,005,16935),
(3003,007,29856),
(3004,010,47860),
(3005,012,99654),
(3006,013,19065),
(3007,016,80956),
(3008,017,45970),
(3009,018,03527),
(3010,021,99362),
(3011,023,27290),
(3012,028,32895),
(3013,026,59876),
(3014,030,66319),
(3015,031,35690);

--ΔΕΔΟΜΕΝΑ ΕΝΔΙΑΜΕΣΟΥ ΣΤΑΘΜΟΥ
/* Έχω κάνει την παραδοχή ότι το αεροδρόμιο μας είναι σε μια πολιτεία των ΗΠΑ, έστω LA, συνεπώς σε κάποιες πτήσεις θα κάνει ενδιάμεση στάση σε άλλα αεροδρόμια.
Εδώ στο id_airport έχω βάλει το id του αεροδρομίου στο οποίο αντιστοιχεί η ενδιάμεση στάση. */
INSERT INTO "MID"("id_mid","id_line","id_airport") VALUES
(4001, 001, 34869), --ΕΛΛΑΔΑ ΜΕ ΕΝΔΙΑΜΕΣΗ ΣΤΑΣΗ ΝΤΙΣΕΛΝΤΟΡΦ
(4002, 008, 49028),-- ΝΤΟΥΜΠΑΙ ΜΕ ΕΝΔΙΑΜΕΣΗ ΣΤΑΣΗ ΠΑΡΙΣΙ
(4003, 017, 36490),-- ΙΣΠΑΝΙΑ ΜΕ ΕΝΔΙΑΜΕΣΗ ΣΤΑΣΗ ΟΛΛΑΝΔΙΑ
(4004, 020, 29856),-- ΡΩΣΙΑ ΜΕ ΕΝΔΙΑΜΕΣΗ ΣΤΑΣΗ ΔΟΥΒΛΙΝΟ
(4005, 029, 80956),-- ΣΙΓΚΑΠΟΥΡΗ ΜΕ ΕΝΔΙΑΜΕΣΗ ΣΤΑΣΗ ΤΟΥΡΚΙΑ
(4006, 031, 66319);-- ΠΟΡΤΟΓΑΛΙΑ ΜΕ ΕΝΔΙΑΜΕΣΗ ΣΤΑΣΗ ΙΤΑΛΙΑ

 INSERT INTO "CHECKIN"("number","open_time","close_time","id_airline","id_line")VALUES
 ('00-05','04:15:00','07:15:00','AEG',001),
 ('06-11','18:20:00','21:20:00','AER',002),
 ('12-17','23:55:00','02:55:00','AIC',004),
 ('18-23','12:50:00','15:50:00','AMA',006),
 ('24-29','22:40:00','01:40:00','EMI',008),
 ('30-35','04:00:00','07:00:00','IBE',009),
 ('36-41','04:30:00','07:30:00','ITA',011),
 ('42-47','07:55:00','10:55:00','TAP',014),
 ('48-53','10:20:00','13:20:00','TUA',015),
 ('00-05','20:45:00','23:45:00','AEG',019),
 ('06-11','07:20:00','10:20:00','AER',020),
 ('54-59','11:50:00','14:50:00','BRA',022),
 ('60-65','21:15:00','00:15:00','EUW',024),
 ('30-35','22:13:00','01:13:00','IBE',025),
 ('66-71','07:00:00','10:00:00','VUE',027),
 ('72-77','16:30:00','19:30:00','SIN',029)
 ;
