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
            cur.execute("SELECT AL.name_airline,AI.name_airplane,AL.country,L.time_line,time(F.date_flight)\
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
            cur.execute("SELECT AL.name_airline,AI.name_airplane,AL.country,L.time_line,time(F.date_flight)\
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


if __name__ == '__main__':
    while True:
        x = input("Για αφίξεις πάτα a, για αποχωρήσεις πάτα d αλλιώς enter: ")
        if x == "a":
            print("------------")
            print("Arrival Date")
            print("------------")
            for row in get_dates(x):
                print(row[0])
            y = input("Διάλεξε μία από τις παραπάνω διαθέσιμες ημερομηνίες: ")
            validate(y)
            l = ["Airline ", "Airplane" , "From", "Time_Scheduled"," Time_expected"]
            print("-----------------------------------------------------------------------------------------------")
            print('{:<21s}{:<20s}{:<18s}{:<22s}{:<22s}'.format(l[0],l[1],l[2],l[3],l[4]))
            print("-----------------------------------------------------------------------------------------------")
            for row in get_arrivals(y):
                print('{:<21s}{:<20s}{:<18s}{:<22s}{:<22s}'.format(row[0],row[1],row[2],row[3],row[4]))

        elif x == "d":
            print("--------------")
            print("Departure Date")
            print("--------------")
            for row in get_dates(x):
                print(row[0])
            y = input("Διάλεξε μία από τις παραπάνω διαθέσιμες ημερομηνίες: ")
            validate(y)
            l = ["Airline ", "Airplane" , "To", "Time_Scheduled"," Time_expected"]
            print("-----------------------------------------------------------------------------------------------")
            print('{:<21s}{:<20s}{:<16s}{:<22s}{:<22s}'.format(l[0],l[1],l[2],l[3],l[4]))
            print("-----------------------------------------------------------------------------------------------")
            for row in get_departures(y):
                print('{:<21s}{:<20s}{:<18s}{:<22s}{:<22s}'.format(row[0],row[1],row[2],row[3],row[4]))
        else:
            break
