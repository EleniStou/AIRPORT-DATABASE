import sqlite3 as lite
import os
import datetime
from os import system

db_name = "airport.sqlite"
dir = '.'
db = os.path.join(dir,db_name)
#Συνάρτηση που ελέγχει αν είναι έγκυρη η μορφή της ημερομηνίας που δίνει ο χρήστης 
def validate(date_text):
    b = True
    try:
        b = bool(datetime.datetime.strptime(date_text, '%Y-%m-%d'))
    except ValueError:
        b = False
    return b

#Συνάρτηση που ελέγχει αν είναι έγκυρη η μορφή του ονόματος της χώρας που δίνει ο χρήστης 
def validcountry(x):
    b = True
    if not all(i in  list("ΑΒΓΔΕΖΗΘΙΪΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ ") for i in list(x)):
        b = False
    return b

#Συνάρτηση που επιστρέφει τις ημερομηνίες αφίξεων/αναχωρήσεων που υπάρχουν στη βάση
def get_dates(x):
    try:
        conn = lite.connect(db)
        with conn:
            if x == "a":
                table = "ARRIVAL"
            else:
                table = "DEPARTURE"
            cur = conn.cursor()
            cur.execute("SELECT DISTINCT strftime('%Y %m %d',F.date_flight)\
                        FROM {} AS AR JOIN LINE AS L ON AR.id_line = L.id_line\
                        JOIN FLIGHT AS F ON L.id_line = F.id_line\
                        JOIN AIRPLANE AS AI ON F.id_airplane = AI.id_airplane\
                        JOIN AIRLINE AS AL ON AI.id_airline = AL.id_airline".format(table))
    
            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0
            
#Συνάρτηση που επιστρέφει πληροφορίες για τις αφίξεις γνωρίζοντας την ημερομηνία της πτήσης 
def get_arrivals(y):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT F.id_flight,AL.name_airline,AI.name_airplane,L2.time_line,time(F.date_flight),AL.country,\
                        CASE \
	                        WHEN A2.country IS NULL THEN  '-'\
	                        ELSE A2.country\
                        END as 'Via'\
                        FROM AIRLINE AS AL JOIN AIRPLANE AS AI ON AI.id_airline = AL.id_airline\
                        JOIN FLIGHT AS F ON F.id_airplane = AI.id_airplane\
                        JOIN LINE AS L2 ON L2.id_line = F.id_line\
                        JOIN ARRIVAL AS A ON A.id_line = L2.id_line\
                        JOIN LINE AS L1 ON A.id_line = L1.id_line\
                        LEFT JOIN MID AS M ON L1.id_line = M.id_line\
                        LEFT JOIN AIRPORT AS A2 ON M.id_airport = A2.id_airport\
                        WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d',?)",(y,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστρέφει πληροφορίες για τις αναχωρήσεις γνωρίζοντας την ημερομηνία της πτήσης 
def get_departures(y):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT F.id_flight,AL.name_airline,AI.name_airplane,L2.time_line,time(F.date_flight),AL.country,\
                        CASE\
                        	WHEN A2.country IS NULL THEN  '-'\
                        	ELSE A2.country\
                        END as 'Via'\
                        FROM AIRLINE AS AL JOIN AIRPLANE AS AI ON AI.id_airline = AL.id_airline\
                        JOIN FLIGHT AS F ON F.id_airplane = AI.id_airplane\
                        JOIN LINE AS L2 ON L2.id_line = F.id_line\
                        JOIN DEPARTURE AS D ON D.id_line = L2.id_line\
                        JOIN LINE AS L1 ON D.id_line = L1.id_line \
                        LEFT JOIN MID AS M ON L1.id_line = M.id_line\
                        LEFT JOIN AIRPORT AS A2 ON M.id_airport = A2.id_airport\
                        WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d',?)",(y,))\

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστρέφει πληροφορίες για την αεροπορική εταιρία γνωρίζοντας το id της πτήσης
def get_info_airline(z2):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT A.id_airline ,name_airline,country,town,email,web,phone\
                        FROM AIRLINE AS A JOIN AIRPLANE AS AI ON A.id_airline = AI.id_airline\
                        JOIN FLIGHT AS F ON AI.id_airplane = F.id_airplane\
                        WHERE F.id_flight = ?",(z2,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστρέφει πληροφορίες για το αεροπλάνο γνωρίζοντας το id της πτήσης
def get_info_airplane(z2):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT name_airplane,seats,baggage,id_airline,name_category\
                        FROM FLIGHT AS F JOIN AIRPLANE AS A ON F.id_airplane = A.id_airplane\
                        WHERE F.id_flight = ?",(z2,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστρέφει πληροφορίες για τον τόπο άφιξης γνωρίζοντας το id της πτήσης
def get_info_arrival(z2):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT name_airport,country,town\
                        FROM FLIGHT AS F JOIN LINE AS L ON F.id_line = L.id_line\
                        JOIN ARRIVAL AS A1 ON L.id_line = A1.id_line\
                        JOIN AIRPORT AS A2 ON A1.id_airport = A2.id_airport\
                        WHERE F.id_flight = ?",(z2,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστρέφει πληροφορίες για τον τόπο αναχώρησης γνωρίζοντας το id της πτήσης
def get_info_departure(z2):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT name_airport,country,town\
                        FROM FLIGHT AS F JOIN LINE AS L ON F.id_line = L.id_line\
                        JOIN DEPARTURE AS D ON L.id_line = D.id_line\
                        JOIN AIRPORT AS A2 ON D.id_airport = A2.id_airport\
                        WHERE F.id_flight = ?",(z2,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστρέφει την καθυστέρηση της πτήσης με βάση την προγραμματισμένη ώρα γραμμής,γνωρίζοντας το id της πτήσης 
def get_delay(z2):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT ((strftime('%H',time(F.date_flight)) - strftime('%H',L.time_line))*60)+(strftime('%M',time(F.date_flight))-strftime('%M',L.time_line)) as delay \
                        FROM FLIGHT as F join LINE as L on F.id_line = L.id_line  \
                        WHERE F.id_flight = ?",(z2,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστέφει τις χώρες για τις οποίες υπάρχει δρομολόγιο από το αεροδρόμιο μας
def get_country():
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT DISTINCT country\
                        FROM AIRPORT")

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστέφει ποιές μέρες υπάρχει προγραμματισμένο δρομολόγιο για συγκεκριμένη χώρα
def get_flight_plan(y):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT L.id_line,day_line,time_line,country,town \
                        FROM LINE AS L JOIN DEPARTURE AS D ON L.id_line = D.id_line \
                        JOIN AIRPORT AS A2 ON D.id_airport = A2.id_airport \
                        WHERE country = ?",(y,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστέφει τις ώρες που είναι ανοιχτά τα check-in booths για συγκεκριμένη γραμμή (προγραμματισμένη πτήση)
def get_times_checkin(z2):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT open_time, close_time \
                        FROM CHECKIN AS C JOIN LINE AS L ON C.id_line = L.id_line \
                        WHERE L.id_line = ?",(z2,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστρέφει πληροφορίες για την αεροπορική εταιρία γνωρίζοντας το id της γραμμής
def get_info_line_airline(z2):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT A.id_airline ,name_airline,country,town,email,web,phone \
                        FROM LINE AS L JOIN CHECKIN AS C ON L.id_line = C.id_line \
                        JOIN AIRLINE AS A ON A.id_airline = C.id_airline \
                        WHERE L.id_line = ?",(z2,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

#Συνάρτηση που επιστρέφει πληροφορίες για τον τόπο αναχώρησης γνωρίζοντας το id της γραμμής
def get_info_line_departure(z2):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT name_airport,country,town \
                        FROM AIRPORT AS A JOIN DEPARTURE AS D ON A.id_airport = D.id_airport \
                        JOIN LINE AS L ON D.id_line = L.id_line \
                        WHERE L.id_line = ?",(z2,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

if __name__ == '__main__':
    while True:
        _ = system('clear')
        x = input("Για αφίξεις πάτα a, για αποχωρήσεις πάτα d, για σχέδιο πτήσης πάτα f αλλιώς enter: ")
        print()
        if x == "a":
            print("------------")
            print("Arrival Date")
            print("------------")
            for row in get_dates(x):
                print(row[0])
            print()    
            y = input("Διάλεξε μία από τις παραπάνω διαθέσιμες ημερομηνίες (YYYY-MM-DD): ")
            print()
            while not validate(y):
                y = input("Λανθασμένη μορφή ημερομηνίας, δώσε την ημερομηνία σε σωστή μορφή YYYY-MM-DD:")
                print()
            l = ["Flight no.","Airline ", "Airplane" , "Time_Scheduled"," Time_expected", "From",'Via']
            print("------------------------------------------------------------------------------------------------------------------------------------------------------")
            print('{:<19s}{:<31s}{:<20s}{:<22s}{:<22s}{:<28s}{:<28s}'.format(l[0],l[1],l[2],l[3],l[4],l[5],l[6]))
            print("------------------------------------------------------------------------------------------------------------------------------------------------------")
            for row in get_arrivals(y):
                print('{:<19d}{:<31s}{:<20s}{:<22s}{:<22s}{:<28s}{:<28s}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6]))
            print()    
            z = input("Για περισσότερες πληροφορίες πληκτρολόγησε αριθμό πτήσης (Flight no.) αλλιώς enter: ")
            print()
            z2 = z 
            while z != "":
                z = input("Πάτα 1) για πληροφορίες αεροπορικής εταιρίας,      \n 2) για πληροφορίες του αεροπλάνου,      \n 3) για πληροφορίες του τόπου άφιξης και      \n 4) για υπολογισμό καθυστέρησης της πτήσης αλλιώς enter: ")
                print()
                if z == "1":
                    l = ["Airline","Name ", "Country" , "Town", "email"," web","phone"]
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18s}'.format(l[0],l[1],l[2],l[3],l[4],l[5],l[6]))
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    for row in get_info_airline(z2):
                        print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18d}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6]))
                    print()
                elif z == "2":
                    l = ["Name","Seats", "Baggage" , "Airline", "Category"]
                    print("---------------------------------------------------------------------------------------------------------------")
                    print('{:<18s}{:<19s}{:<21s}{:<21s}{:<22s}'.format(l[0],l[1],l[2],l[3],l[4]))
                    print("---------------------------------------------------------------------------------------------------------------")
                    for row in get_info_airplane(z2):
                        print('{:<18s}{:<19d}{:<21d}{:<21s}{:<22s}'.format(row[0],row[1],row[2],row[3],row[4]))
                    print()
                elif z == "3":
                    l = ["Name of Airport","Country", "Town" ]
                    print("---------------------------------------------------------------------------------")
                    print('{:<52s}{:<18s}{:<18s}'.format(l[0],l[1],l[2]))
                    print("---------------------------------------------------------------------------------")
                    for row in get_info_arrival(z2):
                        print('{:<52s}{:<18s}{:<18s}'.format(row[0],row[1],row[2]))
                    print()
                elif z == "4":
                    l = ["Delay(minutes)" ]
                    print("----------------")
                    print('{:<16s}'.format(l[0]))
                    print("----------------")
                    for row in get_delay(z2):
                        print('{:<16d}'.format(row[0]))
                    print()
            
                 
        elif x == "d":
            print("--------------")
            print("Departure Date")
            print("--------------")
            for row in get_dates(x):
                print(row[0])
            print()
            y = input("Διάλεξε μία από τις παραπάνω διαθέσιμες ημερομηνίες (YYYY-MM-DD): ")
            print()
            while not validate(y):
                y = input("Λανθασμένη μορφή ημερομηνίας, δώσε την ημερομηνία σε σωστή μορφή YYYY-MM-DD:")
                print()
            l = ["Flight no.","Airline ", "Airplane" , "Time_Scheduled"," Time_expected", "To","Via"]
            print("-------------------------------------------------------------------------------------------------------------------------------------------------------")
            print('{:<19s}{:<31s}{:<20s}{:<22s}{:<22s}{:<28s}{:<28s}'.format(l[0],l[1],l[2],l[3],l[4],l[5],l[6]))
            print("-------------------------------------------------------------------------------------------------------------------------------------------------------")
            for row in get_departures(y):
                print('{:<19d}{:<31s}{:<20s}{:<22s}{:<22s}{:<28s}{:<28s}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6]))
            print()
            z = input("Για περισσότερες πληροφορίες πληκτρολόγησε αριθμό πτήσης (Flight no.) αλλιώς enter: ")
            print()
            z2 = z 
            while z != "":
                z = input("Πάτα 1) για πληροφορίες αεροπορικής εταιρίας,      \n 2) για πληροφορίες του αεροπλάνου,      \n 3) για πληροφορίες του τόπου προορισμού και      \n 4) για υπολογισμό καθυστέρησης της πτήσης αλλιώς enter: ")
                print()
                if z == "1":
                    l = ["Airline","Name ", "Country" , "Town", "email"," web","phone"]
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18s}'.format(l[0],l[1],l[2],l[3],l[4],l[5],l[6]))
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    for row in get_info_airline(z2):
                        print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18d}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6]))
                    print()
                elif z == "2":
                    l = ["Name","Seats", "Baggage" , "Airline", "Category"]
                    print("---------------------------------------------------------------------------------------------------------------")
                    print('{:<18s}{:<19s}{:<21s}{:<21s}{:<22s}'.format(l[0],l[1],l[2],l[3],l[4]))
                    print("---------------------------------------------------------------------------------------------------------------")
                    for row in get_info_airplane(z2):
                        print('{:<18s}{:<19d}{:<21d}{:<21s}{:<22s}'.format(row[0],row[1],row[2],row[3],row[4]))
                    print()
                elif z == "3":
                    l = ["Name of Airport","Country", "Town" ]
                    print("---------------------------------------------------------------------------------")
                    print('{:<52s}{:<18s}{:<18s}'.format(l[0],l[1],l[2]))
                    print("---------------------------------------------------------------------------------")
                    for row in get_info_departure(z2):
                        print('{:<52s}{:<18s}{:<18s}'.format(row[0],row[1],row[2]))
                    print()
                elif z == "4":
                    l = ["Delay(minutes)" ]
                    print("----------------")
                    print('{:<25s}'.format(l[0]))
                    print("----------------")
                    for row in get_delay(z2):
                        print('{:<25d}'.format(row[0]))
                    print()

        elif x == "f":
            l = ["Country" ]
            print("----------------")
            print('{:<25s}'.format(l[0]))
            print("----------------")
            for row in get_country():
                print('{:<25s}'.format(row[0]))
            print()
            y = input("Διάλεξε χώρα που θες να ταξιδέψεις (κεφαλαίοι ελληνικοί χαρακτήρες): ")
            print()
            while not validcountry(y):
                y = input("Λανθασμένη μορφή, δώσε χώρα με κεφαλαίους ελληνικούς χαρακτήρες: ")
                print()
            l = ["Line no.","Day","Time_Scheduled","Country", "Town" ]
            print("---------------------------------------------------------------------------------")
            print('{:<18s}{:<18s}{:<22s}{:<18s}{:<18s}'.format(l[0],l[1],l[2],l[3],l[4]))
            print("---------------------------------------------------------------------------------")
            for row in get_flight_plan(y):
                print('{:<18d}{:<18s}{:<22s}{:<18s}{:<18s}'.format(row[0],row[1],row[2],row[3],row[4]))
            print()
            z = input("Για περισσότερες πληροφορίες πληκτρολόγησε αριθμό γραμμής (Line no.) αλλιώς enter: ")
            print()
            z2 = z 
            while z != "":
                z = input("Πάτα 1) για πληροφορίες check-in,      \n 2) για πληροφορίες αεροπορικής εταιρίας,      \n 3) για πληροφορίες του τόπου προορισμού  αλλιώς enter: ")
                print()
                if z == "1":
                    l = ["Time-on CHECK-IN","Time-off CHECK-IN" ]
                    print("-------------------------------------")
                    print('{:<18s}{:<18s}'.format(l[0],l[1]))
                    print("-------------------------------------")
                    for row in get_times_checkin(z2):
                        print('{:<18s}{:<18s}'.format(row[0],row[1]))    
                    print()
                elif z == "2":
                    l = ["Airline","Name ", "Country" , "Town", "email"," web","phone"]
                    print("----------------------------------------------------------------------------------------------------------------------------------------------------")
                    print('{:<21s}{:<18s}{:<31s}{:<18s}{:<35s}{:<25s}{:<18s}'.format(l[0],l[1],l[2],l[3],l[4],l[5],l[6]))
                    print("----------------------------------------------------------------------------------------------------------------------------------------------------")
                    for row in get_info_line_airline(z2):
                        print('{:<21s}{:<18s}{:<31s}{:<18s}{:<35s}{:<25s}{:<18d}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6])) 
                    print()
                elif z == "3":
                    l = ["Name of Airport","Country", "Town" ]
                    print("---------------------------------------------------------------------------------")
                    print('{:<52s}{:<18s}{:<18s}'.format(l[0],l[1],l[2]))
                    print("---------------------------------------------------------------------------------")
                    for row in get_info_line_departure(z2):
                        print('{:<52s}{:<18s}{:<18s}'.format(row[0],row[1],row[2]))
                    print()
                         
        else:
            break
