--Ερωτήματα SQL για ενδεικτικές τυπικές αναζητήσεις, όπως αυτές προκύπτουν από την προσδοκώμενη χρήση της ΒΔ

--1.Εμφάνιση αφίξεων της ημερομηνίας 2021-01-10 κτλ
--(Αεροπορική εταιρία,αεροπλάνο,χώρα προέλευσης,προγραμματισμένη ώρα,τελική ώρα)
SELECT F.id_flight,F.name_terminal,AL.name_airline,AI.name_airplane,AL.country,L.time_line,time(F.date_flight)
FROM ARRIVAL AS AR JOIN LINE AS L ON AR.id_line = L.id_line
JOIN FLIGHT AS F ON L.id_line = F.id_line
JOIN AIRPLANE AS AI ON F.id_airplane = AI.id_airplane
JOIN AIRLINE AS AL ON AI.id_airline = AL.id_airline
WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d','2021-01-10');


--2.Εμφάνιση προορισμών της ημερομηνίας 2021-01-10 κτλ
--(Αεροπορική εταιρία,χώρα προορισμού,προγραμματισμένη ώρα,τελική ώρα)
SELECT F.id_flight,F.name_terminal,AL.name_airline,AI.name_airplane,AL.country,L.time_line,time(F.date_flight)
FROM DEPARTURE AS D JOIN LINE AS L ON D.id_line = L.id_line
JOIN FLIGHT AS F ON L.id_line = F.id_line
JOIN AIRPLANE AS AI ON F.id_airplane = AI.id_airplane
JOIN AIRLINE AS AL ON AI.id_airline = AL.id_airline
WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d','2021-01-10');


--3.Εμφάνιση καθυστέρησης όλων των πτήσεων (εξαιρούνται αυτές που δεν έχουν καθυστέρηση)
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

--6.Εμφάνιση πλήθους πτήσεων χωρίς καθυστερήσεις
SELECT COUNT(F.id_flight) AS FLIGHTS
FROM FLIGHT as F join LINE as L on F.id_line = L.id_line 
WHERE ((strftime('%H',time(F.date_flight)) - strftime('%H',L.time_line))*60)+(strftime('%M',time(F.date_flight))-strftime('%M',L.time_line)) = 0;

--7.Eμφάνιση αφίξεων και ενδιάμεσων στάσεων
--(id γραμμής, χώρα άφιξης,χώρα ενδιάμεσης στάσης)
SELECT L.id_line, A1.country as 'From', A2.country as 'Via'
FROM AIRPORT AS A1 JOIN ARRIVAL AS A ON A1.id_airport = A.id_airport
JOIN LINE AS L ON A.id_line = L.id_line
JOIN MID AS M ON L.id_line = M.id_line
JOIN AIRPORT AS A2 ON M.id_airport = A2.id_airport;
--Αντίστοιχα για προορισμούς
SELECT L.id_line, A1.country as 'To', A2.country as 'Via'
FROM AIRPORT AS A1 JOIN DEPARTURE AS D ON A1.id_airport = D.id_airport
JOIN LINE AS L ON D.id_line = L.id_line
JOIN MID AS M ON L.id_line = M.id_line
JOIN AIRPORT AS A2 ON M.id_airport = A2.id_airport;

--8.Ημερομηνίες αφίξεων
SELECT DISTINCT strftime('%Y %m %d',F.date_flight)
FROM ARRIVAL AS AR JOIN LINE AS L ON AR.id_line = L.id_line
JOIN FLIGHT AS F ON L.id_line = F.id_line
ORDER BY strftime('%Y %m %d',F.date_flight) ;
--Αντίστοιχα για προορισμούς
SELECT DISTINCT strftime('%Y %m %d',F.date_flight)
FROM DEPARTURE AS D JOIN LINE AS L ON D.id_line = L.id_line
JOIN FLIGHT AS F ON L.id_line = F.id_line
ORDER BY strftime('%Y %m %d',F.date_flight);

--9.Ποιές πύλες χρησιμοποιούνται πχ στις 2021-01-05 
select DISTINCT name_gate 
FROM TERMINAL AS T JOIN GATE as G ON T.name_terminal = G.name_terminal 
JOIN FLIGHT as F ON T.name_terminal = F.name_terminal 
WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d','2021-01-05');

--10.Πληροφορίες για το αεεροπλάνο που πραγματοποιεί μια πτήση πχ αυτήν με id 152
SELECT name_airplane,seats,baggage,id_airline,name_category
FROM FLIGHT AS F JOIN AIRPLANE AS A ON F.id_airplane = A.id_airplane
WHERE F.id_flight = '152';

--11.Πληροφορίες για τον τόπο άφιξης πχ id πτήσης 152
SELECT name_airport,country,town
FROM FLIGHT AS F JOIN LINE AS L ON F.id_line = L.id_line
JOIN ARRIVAL AS A1 ON L.id_line = A1.id_line
JOIN AIRPORT AS A2 ON A1.id_airport = A2.id_airport
WHERE F.id_flight = '152';
--Αντίστοιχα για τόπο προορισμού πχ id πτήσης 110
SELECT name_airport,country,town
FROM FLIGHT AS F JOIN LINE AS L ON F.id_line = L.id_line
JOIN DEPARTURE AS D ON L.id_line = D.id_line
JOIN AIRPORT AS A2 ON D.id_airport = A2.id_airport
WHERE F.id_flight = '110';

--12.Πληροφορίες για το πότε υπάρχει δρομολόγιο (Ημέρα/Ώρα) για συγκεκριμένη χώρα πχ. ΕΛΛΑΔΑ
SELECT L.id_line,day_line,time_line,country,town 
FROM LINE AS L JOIN DEPARTURE AS D ON L.id_line = D.id_line 
JOIN AIRPORT AS A2 ON D.id_airport = A2.id_airport 
WHERE country = 'ΕΛΛΑΔΑ';

--13.Ώρες που είναι ανοιχτά τα check-in booths για συγκεκριμένη γραμμή (προγραμματισμένη πτήση) πχ id γραμμής 21
SELECT open_time, close_time 
FROM CHECKIN AS C JOIN LINE AS L ON C.id_line = L.id_line 
WHERE L.id_line = '21';
