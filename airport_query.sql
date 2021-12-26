------
--1.Εμφάνιση αφίξεων της ημερομηνίας 2021-01-10 κτλ
--(Αεροπορική εταιρία,αεροπλάνο,χώρα προέλευσης,προγραμματισμένη ώρα,τελική ώρα)
SELECT AL.name_airline,AI.name_airplane,AL.country,L.time_line,time(F.date_flight)
FROM ARRIVAL AS AR JOIN LINE AS L ON AR.id_line = L.id_line
JOIN FLIGHT AS F ON L.id_line = F.id_line
JOIN AIRPLANE AS AI ON F.id_airplane = AI.id_airplane
JOIN AIRLINE AS AL ON AI.id_airline = AL.id_airline
WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d','2021-01-10');


--2.Εμφάνιση προορισμών της ημερομηνίας 2021-01-10 κτλ
--(Αεροπορική εταιρία,χώρα προορισμού,προγραμματισμένη ώρα,τελική ώρα)
SELECT AL.name_airline,AI.name_airplane,AL.country,L.time_line,time(F.date_flight)
FROM DEPARTURE AS D JOIN LINE AS L ON D.id_line = L.id_line
JOIN FLIGHT AS F ON L.id_line = F.id_line
JOIN AIRPLANE AS AI ON F.id_airplane = AI.id_airplane
JOIN AIRLINE AS AL ON AI.id_airline = AL.id_airline
WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d','2021-01-10');


--3.Εμφάνιση καθυστέρησης όλων των πτήσεων
--(id πτήσης , καθυστέρηση σε λεπτά)
SELECT F.id_flight,((strftime('%H',time(F.date_flight)) - strftime('%H',L.time_line))*60)+(strftime('%M',time(F.date_flight))-strftime('%M',L.time_line)) as delay 
FROM FLIGHT as F join LINE as L on F.id_line = L.id_line  and delay <> 0;
--ΜΠορεί να χωριστεί σε προορισμό και άφιξη ώστε να εμφανίζεται και η αντίστοιχη χώρα
--ΠΡΟΟΡΙΣΜΟΣ
SELECT F.id_flight,A.country,((strftime('%H',time(F.date_flight)) - strftime('%H',L.time_line))*60)+(strftime('%M',time(F.date_flight))-strftime('%M',L.time_line)) as delay 
FROM FLIGHT as F join LINE as L on F.id_line = L.id_line  and delay <> 0
join DEPARTURE as D on L.id_line = D.id_line
join AIRPORT as A on D.id_airport = A.id_airport;
--ΑΦΙΞΗ
SELECT F.id_flight,A.country,((strftime('%H',time(F.date_flight)) - strftime('%H',L.time_line))*60)+(strftime('%M',time(F.date_flight))-strftime('%M',L.time_line)) as delay 
FROM FLIGHT as F join LINE as L on F.id_line = L.id_line  and delay <> 0
join ARRIVAL as AR on L.id_line = AR.id_line
join AIRPORT as A on AR.id_airport = A.id_airport;

--4.Εμφάνιση πτήσης μέγιστης καθυστέρησης
--(id πτήσης , καθυστέρηση σε λεπτά)
SELECT F.id_flight,max(((strftime('%H',time(F.date_flight)) - strftime('%H',L.time_line))*60)+(strftime('%M',time(F.date_flight))-strftime('%M',L.time_line))) as delay 
FROM FLIGHT as F join LINE as L on F.id_line = L.id_line ;
--ΜΠορεί να χωριστεί σε προορισμό και άφιξη ώστε να εμφανίζεται και η αντίστοιχη χώρα
--ΠΡΟΟΡΙΣΜΟΣ
SELECT F.id_flight,A.country,max(((strftime('%H',time(F.date_flight)) - strftime('%H',L.time_line))*60)+(strftime('%M',time(F.date_flight))-strftime('%M',L.time_line))) as delay 
FROM FLIGHT as F join LINE as L on F.id_line = L.id_line 
join DEPARTURE as D on L.id_line = D.id_line
join AIRPORT as A on D.id_airport = A.id_airport;
--ΑΦΙΞΗ
SELECT F.id_flight,A.country,max(((strftime('%H',time(F.date_flight)) - strftime('%H',L.time_line))*60)+(strftime('%M',time(F.date_flight))-strftime('%M',L.time_line))) as delay 
FROM FLIGHT as F join LINE as L on F.id_line = L.id_line 
join ARRIVAL as AR on L.id_line = AR.id_line
join AIRPORT as A on AR.id_airport = A.id_airport;

--5.Εμφάνιση στοιχείων αεροπορικών εταιριών
--(id,όνομα,email,χώρα,πόλη,web,τηλέφωνο,check-in)
SELECT DISTINCT A.id_airline ,name_airline,country,town,email,web,phone,number
FROM AIRLINE AS A JOIN CHECKIN AS C ON A.id_airline = C.id_airline; 