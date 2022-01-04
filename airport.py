import sqlite3 as lite
import os
import datetime

db_name = "airport.sqlite"
dir = '.'
db = os.path.join(dir,db_name)

def validate(date_text):
    try:
        datetime.datetime.strptime(date_text, '%Y-%m-%d')
    except ValueError:
        raise ValueError("Λανθασμένη μορφή ημερομηνίας, Θα έπρεπε να είναι YYYY-MM-DD")

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
                        JOIN AIRLINE AS AL ON AI.id_airline = AL.id_airline\
                        ORDER BY strftime('%Y %m %d',F.date_flight)".format(table))
    
            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0
            


def get_arrivals(y):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT F.id_flight,AL.name_airline,AI.name_airplane,AL.country,L.time_line,time(F.date_flight)\
                        FROM ARRIVAL AS AR JOIN LINE AS L ON AR.id_line = L.id_line\
                        JOIN FLIGHT AS F ON L.id_line = F.id_line\
                        JOIN AIRPLANE AS AI ON F.id_airplane = AI.id_airplane\
                        JOIN AIRLINE AS AL ON AI.id_airline = AL.id_airline\
                        WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d',?)",(y,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

def get_departures(y):
    try:
        conn = lite.connect(db)
        with conn:
            cur = conn.cursor()
            cur.execute("SELECT F.id_flight,AL.name_airline,AI.name_airplane,AL.country,L.time_line,time(F.date_flight)\
                        FROM DEPARTURE AS D JOIN LINE AS L ON D.id_line = L.id_line\
                        JOIN FLIGHT AS F ON L.id_line = F.id_line\
                        JOIN AIRPLANE AS AI ON F.id_airplane = AI.id_airplane\
                        JOIN AIRLINE AS AL ON AI.id_airline = AL.id_airline\
                        WHERE strftime('%Y %m %d',F.date_flight) = strftime('%Y %m %d',?)",(y,))

            rows = cur.fetchall()
            return rows
    except lite.Error as e:
        print(e)
        return 0

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
        x = input("Για αφίξεις πάτα a, για αποχωρήσεις πάτα d, για σχέδιο πτήσης πάτα f αλλιώς enter: ")
        if x == "a":
            print("------------")
            print("Arrival Date")
            print("------------")
            for row in get_dates(x):
                print(row[0])
            y = input("Διάλεξε μία από τις παραπάνω διαθέσιμες ημερομηνίες: ")
            validate(y)
            l = ["Flight no.","Airline ", "Airplane" , "From", "Time_Scheduled"," Time_expected"]
            print("-------------------------------------------------------------------------------------------------------------------")
            print('{:<19s}{:<21s}{:<20s}{:<28s}{:<22s}{:<22s}'.format(l[0],l[1],l[2],l[3],l[4],l[5]))
            print("-------------------------------------------------------------------------------------------------------------------")
            for row in get_arrivals(y):
                print('{:<19d}{:<21s}{:<20s}{:<28s}{:<22s}{:<22s}'.format(row[0],row[1],row[2],row[3],row[4],row[5]))
            z = input("Για περισσότερες πληροφορίες πληκτρολόγησε αριθμό πτήσης αλλιώς enter: ")
            z2 = z 
            while z != "":
                z = input("Πάτα 1) για πληροφορίες αεροπορικής εταιρίας,      \n 2) για πληροφορίες του αεροπλάνου,      \n 3) για πληροφορίες του τόπου άφιξης και      \n 4) για υπολογισμό καθυστέρησης της πτήσης αλλιώς enter: ")
                if z == "1":
                    l = ["Airline","Name ", "Country" , "Town", "email"," web","phone"]
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18s}'.format(l[0],l[1],l[2],l[3],l[4],l[5],l[6]))
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    for row in get_info_airline(z2):
                        print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18d}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6]))
                elif z == "2":
                    l = ["Name","Seats", "Baggage" , "Airline", "Category"]
                    print("---------------------------------------------------------------------------------------------------------------")
                    print('{:<18s}{:<19s}{:<21s}{:<21s}{:<22s}'.format(l[0],l[1],l[2],l[3],l[4]))
                    print("---------------------------------------------------------------------------------------------------------------")
                    for row in get_info_airplane(z2):
                        print('{:<18s}{:<19d}{:<21d}{:<21s}{:<22s}'.format(row[0],row[1],row[2],row[3],row[4]))
                elif z == "3":
                    l = ["Name of Airport","Country", "Town" ]
                    print("---------------------------------------------------------------------------------")
                    print('{:<52s}{:<18s}{:<18s}'.format(l[0],l[1],l[2]))
                    print("---------------------------------------------------------------------------------")
                    for row in get_info_arrival(z2):
                        print('{:<52s}{:<18s}{:<18s}'.format(row[0],row[1],row[2]))
                elif z == "4":
                    l = ["Delay(minutes)" ]
                    print("----------------")
                    print('{:<16s}'.format(l[0]))
                    print("----------------")
                    for row in get_delay(z2):
                        print('{:<16d}'.format(row[0]))
            
                 
        elif x == "d":
            print("--------------")
            print("Departure Date")
            print("--------------")
            for row in get_dates(x):
                print(row[0])
            y = input("Διάλεξε μία από τις παραπάνω διαθέσιμες ημερομηνίες: ")
            validate(y)
            l = ["Flight no.","Airline ", "Airplane" , "To", "Time_Scheduled"," Time_expected"]
            print("-------------------------------------------------------------------------------------------------------------------")
            print('{:<19s}{:<21s}{:<20s}{:<28s}{:<22s}{:<22s}'.format(l[0],l[1],l[2],l[3],l[4],l[5]))
            print("-------------------------------------------------------------------------------------------------------------------")
            for row in get_departures(y):
                print('{:<19d}{:<21s}{:<20s}{:<28s}{:<22s}{:<22s}'.format(row[0],row[1],row[2],row[3],row[4],row[5]))
            z = input("Για περισσότερες πληροφορίες πληκτρολόγησε αριθμό πτήσης: ")
            z2 = z 
            while z != "":
                z = input("Πάτα 1) για πληροφορίες αεροπορικής εταιρίας,      \n 2) για πληροφορίες του αεροπλάνου,      \n 3) για πληροφορίες του τόπου προορισμού και      \n 4) για υπολογισμό καθυστέρησης της πτήσης αλλιώς enter: ")
                if z == "1":
                    l = ["Airline","Name ", "Country" , "Town", "email"," web","phone"]
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18s}'.format(l[0],l[1],l[2],l[3],l[4],l[5],l[6]))
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    for row in get_info_airline(z2):
                        print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18d}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6]))
                elif z == "2":
                    l = ["Name","Seats", "Baggage" , "Airline", "Category"]
                    print("---------------------------------------------------------------------------------------------------------------")
                    print('{:<18s}{:<19s}{:<21s}{:<21s}{:<22s}'.format(l[0],l[1],l[2],l[3],l[4]))
                    print("---------------------------------------------------------------------------------------------------------------")
                    for row in get_info_airplane(z2):
                        print('{:<18s}{:<19d}{:<21d}{:<21s}{:<22s}'.format(row[0],row[1],row[2],row[3],row[4]))
                elif z == "3":
                    l = ["Name of Airport","Country", "Town" ]
                    print("---------------------------------------------------------------------------------")
                    print('{:<52s}{:<18s}{:<18s}'.format(l[0],l[1],l[2]))
                    print("---------------------------------------------------------------------------------")
                    for row in get_info_departure(z2):
                        print('{:<52s}{:<18s}{:<18s}'.format(row[0],row[1],row[2]))
                elif z == "4":
                    l = ["Delay(minutes)" ]
                    print("----------------")
                    print('{:<25s}'.format(l[0]))
                    print("----------------")
                    for row in get_delay(z2):
                        print('{:<25d}'.format(row[0]))

        elif x == "f":
            y = input("Διάλεξε χώρα που θες να ταξιδέψεις: ")
            l = ["Line no.","Day","Time_Scheduled","Country", "Town" ]
            print("---------------------------------------------------------------------------------")
            print('{:<18s}{:<18s}{:<22s}{:<18s}{:<18s}'.format(l[0],l[1],l[2],l[3],l[4]))
            print("---------------------------------------------------------------------------------")
            for row in get_flight_plan(y):
                print('{:<18d}{:<18s}{:<22s}{:<18s}{:<18s}'.format(row[0],row[1],row[2],row[3],row[4]))
            z = input("Για περισσότερες πληροφορίες πληκτρολόγησε αριθμό γραμμής: ")
            z2 = z 
            while z != "":
                z = input("Πάτα 1) για πληροφορίες check-in,      \n 2) για πληροφορίες αεροπορικής εταιρίας,      \n 3) για πληροφορίες του τόπου προορισμού  αλλιώς enter: ")
                if z == "1":
                    l = ["Time-on CHECK-IN","Time-off CHECK-IN" ]
                    print("-------------------------------------")
                    print('{:<18s}{:<18s}'.format(l[0],l[1]))
                    print("-------------------------------------")
                    for row in get_times_checkin(z2):
                        print('{:<18s}{:<18s}'.format(row[0],row[1]))    
                elif z == "2":
                    l = ["Airline","Name ", "Country" , "Town", "email"," web","phone"]
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18s}'.format(l[0],l[1],l[2],l[3],l[4],l[5],l[6]))
                    print("-----------------------------------------------------------------------------------------------------------------------------------------------")
                    for row in get_info_line_airline(z2):
                        print('{:<21s}{:<18s}{:<21s}{:<18s}{:<25s}{:<25s}{:<18d}'.format(row[0],row[1],row[2],row[3],row[4],row[5],row[6])) 
                elif z == "3":
                    l = ["Name of Airport","Country", "Town" ]
                    print("---------------------------------------------------------------------------------")
                    print('{:<52s}{:<18s}{:<18s}'.format(l[0],l[1],l[2]))
                    print("---------------------------------------------------------------------------------")
                    for row in get_info_line_departure(z2):
                        print('{:<52s}{:<18s}{:<18s}'.format(row[0],row[1],row[2]))
                         
        else:
            break
