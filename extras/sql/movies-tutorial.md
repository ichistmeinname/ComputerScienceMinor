**Hinweis:** Das komplette Ruby-Programm können Sie unter **(e)** anzeigen.

Bevor wir die erste (sinnvolle) Zeile Code schreiben, müssen wir den `sqlite_connector` einbinden, da wir diesen benötigen, um später mit der Datenbank zu kommunizieren. Wir gehen dabei davon aus, dass sich die Datei `sqlite_connector.rb` im gleichen Verzeichnis befindet wie die Datei, die wir im Folgenen schreiben wollen.

~~~~{.ruby}
require_relative "../sqlite_connector"
~~~~

### Daten programmatisch in die Datenbank eintragen

Zunächst legen wir uns Hilfsfunktionen an, die die entsprechenden Tabellen anlegen (insofern sie nicht schon angelegt worden sind).

~~~~{.ruby}
def setup(db)
 # if the following tables do not exist, create them
 db.execute("CREATE TABLE IF NOT EXISTS film (id INTEGER PRIMARY KEY,
             titel TEXT, erscheinungsjahr INTEGER, bewertung INTEGER, regisseurin INTEGER);")
 db.execute("CREATE TABLE IF NOT EXISTS filmschaffende (mitgliedsnummer INTEGER PRIMARY KEY,
             vorname Text, name TEXT, geburtsdatum DATETIME);")
 db.execute("CREATE TABLE IF NOT EXISTS rolle (film_id INTEGER,
                     mitgliedsnummer INTEGER);")
end;
~~~~

Analog dazu gehen wir für die Beispieldaten vor; auch hier wollen wir nur Daten in die Datenbank einfügen, wenn noch keine Daten vorhanden sind.

~~~~{.ruby}
def fill_database_with_movies(db)
  # fill database with dummy movies, if no data exists
  if db.execute("SELECT * from film;") then
    db.execute("INSERT INTO film (titel,erscheinungsjahr,bewertung,regisseurin) VALUES
                 ('The Imitation Game',2014,8,5);");
    db.execute("INSERT INTO film (titel,erscheinungsjahr,bewertung,regisseurin) VALUES
                 ('Harry Potter and the Chamber of Secrets',2002,7,4);");
    db.execute("INSERT INTO film (titel,erscheinungsjahr,bewertung,regisseurin) VALUES
                 ('The Hitchhikers Guide to the Galaxy',2005,7,6);");
    db.execute("INSERT INTO film (titel,erscheinungsjahr,bewertung,regisseurin) VALUES
                 ('Love Actually',2003,7,7);");
  end;
end;

def fill_database_with_cast(db)
  # fill database with dummy movies, if no data exists
  if db.execute("SELECT * from filmschaffende;") == [] then
    db.execute("INSERT INTO filmschaffende (vorname,name,geburtsdatum) VALUES
                 ('Alan','Rickman','1946-02-21 00:00:00');");
    db.execute("INSERT INTO filmschaffende (vorname,name,geburtsdatum) VALUES
                 ('Benedict','Cumberbatch','1976-07-19 00:00:00');");
    db.execute("INSERT INTO filmschaffende (vorname,name,geburtsdatum) VALUES
                 ('Martin','Freeman','1971-09-08 00:00:00');");
    db.execute("INSERT INTO filmschaffende (vorname,name,geburtsdatum) VALUES
                 ('Chris','Columbus','1958-09-10 00:00:00');");
    db.execute("INSERT INTO filmschaffende (vorname,name,geburtsdatum) VALUES
                 ('Morten','Tyldum','1969-05-19 00:00:00');");
    db.execute("INSERT INTO filmschaffende (vorname,name,geburtsdatum) VALUES
                 ('Gareth','Jennings','1972-01-01 00:00:00');");
    db.execute("INSERT INTO filmschaffende (vorname,name,geburtsdatum) VALUES
                 ('Richard','Curtis','1956-11-08 00:00:00');");
  end;
end;

def fill_database_with_roles(db)
  # fill database with dummy movies, if no data exists
  if db.execute("SELECT * from rolle;") == [] then
    db.execute("INSERT INTO rolle (film_id,mitgliedsnummer) VALUES
                 (2,1);");
    db.execute("INSERT INTO rolle (film_id,mitgliedsnummer) VALUES
                 (1,2);");
    db.execute("INSERT INTO rolle (film_id,mitgliedsnummer) VALUES
                 (3,3);");
    db.execute("INSERT INTO rolle (film_id,mitgliedsnummer) VALUES
                 (3,1);");
    db.execute("INSERT INTO rolle (film_id,mitgliedsnummer) VALUES
                 (4,3);");
    db.execute("INSERT INTO rolle (film_id,mitgliedsnummer) VALUES
                 (4,1);");
  end;
end;
~~~~

Da das Eintragen der Daten gefühlt aufwendiger war als notwendig, werden wir direkt die erste Verbesserung vornehmen. Für ein gegebenes Schema, einen gegebnen Tabellennamen und gegebene Beispielwerte wollen wir "schnell" Daten in die Datenbank hinzufügen. Ein Tabellenchema an sich wollen wir gerne mit Hilfe eines Arrays darstellen. Für die Tabelle "Film" wäre das Schema z.B.

~~~~{.ruby}
movie_scheme = ["titel","erscheinungsjahr","bewertung","regisseurin"];
~~~~

Zunächst überlegen wir uns, wie wir ein gegebenes Schema schnell in einen String umwandeln können. Aus dem obigen Array müsste also der String `"(titel,erscheinungsjahr,bewertung,regisseurin)"` generiert werden. Dazu legen wir uns einen String an, der mit einer öffnenden Klammer beginnt (und mit einer schließenden endet) und für jedes Element im Array das Element sowie ein Komma generiert. Im Falle des letzten Elementes müssen wir dann noch auf das Komma verzichten, da wir sonst den String `"(titel,erscheinungsjahr,bewertung,regisseurin,)"` erhalten würden.

~~~~{.ruby}
def to_scheme_string(scheme_arr)
  scheme_str = "(";
  for i in 0..scheme_arr.size-1 do
    if i == scheme_arr.size-1 then
      scheme_str = scheme_str + scheme_arr[i];
    else
      scheme_str = scheme_str + scheme_arr[i] + ",";
    end;
  end;
  scheme_str = scheme_str + ")";
  return scheme_str;
end;
~~~~

Eine gegebene Datenbank können wir nun mit Hilfe des Tabellennamens, Tabellenschemas und der Daten in Form eines zweidimensionalen Arrays füllen. Wie gehabt, wollen wir erst prüfen, ob bereits Einträge vorhanden sind und nur im Negativfall Daten hinzufügen. Die einzelnen Datensätze (also das innere des zweidimensionalen Arrays) muss wie das Schema in Tupelform transformiert werden. Die Einträge werden einzeln in die Datenbank eingetragen; wir durchlaufen das Werte-Array demtensprechend mit einer `for`-Schleife.

~~~~{.ruby}
def fill_database(db,table_name,table_scheme,values)
  if db.execute("SELECT * from " + table_name + ";") == [] then
    for i in 0..values.size-1 do
      str = "INSERT INTO " + table_name + " ";
      str = str + to_scheme_string(table_scheme) + " ";
      str = str + "VALUES " + to_scheme_string(values[i]) + ";";
      db.execute(str);
    end;
  end;
end;
~~~~

Unsere Datensätze können wir dann mittels Hilfsfunktionen global definieren und später im Programm verwenden.

~~~~{.ruby}
def movies_arr
  # Do not forget to quote string values!
  movie1 = ["'The Imitation Game'","2014","8","5"];
  movie2 = ["'Harry Potter and the Chamber of Secrets'","2002","7","4"];
  movie3 = ["'The Hitchhikers Guide to the Galaxy'","2005","7","6"];
  movie4 = ["'Love Actually'","2003","7","7"];
  return [movie1,movie2,movie3,movie4];
end;

def cast_arr
  # Do not forget to quote string values!
  cast1 = ["'Alan'","'Rickman'","'1946-02-21 00:00:00'"];
  cast2 = ["'Benedict'","'Cumberbatch'","'1976-07-19 00:00:00'"];
  cast3 = ["'Martin'","'Freeman'","'1971-09-08 00:00:00'"]
  cast4 = ["'Chris'","'Columbus'","'1958-09-10 00:00:00'"];
  cast5 = ["'Morten'","'Tyldum'","'1969-05-19 00:00:00'"];
  cast6 = ["'Gareth'","'Jennings'","'1972-01-01 00:00:00'"]
  cast7 = ["'Richard'","'Curtis'","'1956-11-08 00:00:00'"]
  return [cast1,cast2,cast3,cast4,cast5,cast6,cast7];
end;

def roles_arr
  role1 = ["2","1"];
  role2 = ["1","2"];
  role3 = ["3","3"];
  role4 = ["3","1"];
  role5 = ["4","3"];
  role6 = ["4","1"];
  return [role1,role2,role3,role4,role5,role6];
end;
~~~~

Die ersten Bausteine für unser Endprogramm sind bereits vorhanden, so dass wir den folgenden Code bereits niederschreiben können.

~~~~{.ruby}
use_database("../imdb") do |db|

  movie_scheme = ["titel","erscheinungsjahr","bewertung","regisseurin"];
  movie_table  = "film";
  role_scheme  = ["film_id","mitgliedsnummer"];
  role_table   = "rolle";
  cast_scheme  = ["vorname","name","geburtsdatum"];
  cast_table   = "filmschaffende";

  setup(db);

  fill_database(db,movie_table,movie_scheme,movies_arr);
  fill_database(db,cast_table,cast_scheme,cast_arr);
  fill_database(db,role_table,role_scheme,roles_arr);

  # Alternative hätte natürlich auch die erste Variante mit den Hilfsfunktionen gereicht
  # fill_database_with_movies(db);
  # fill_database_with_cast(db);
  # fill_database_with_roles(db);
~~~~

### Menüführung für Suche in der Datenbank

Wir wollen dem Benutzer die Möglichkeit geben, einen Film über die ID (in der Endlösung gibt es auch eine Variante über den Namen) ausgeben zu lassen. Dazu können wir auf altbekannte Weise ein Menü bauen, dass auf Eingabe des Benutzers warten und bei valider Eingabe einen Film aus der Datenbank heraussucht. Die eigentliche Datenbankanfrage überlegen wir uns danach.

~~~~{.ruby}
def query_menu(db);
  print("Waehle einen Film ueber seine ID aus: ");
  id = gets.chop.to_i;
  while id == 0 do
    puts("Inkorrekte Eingabe; gib die ID des Films ein: ");
    id = gets.chop.to_i;
  end;
  table = query_reg_and_actors_by_id(db,id);
  return table;
end;
~~~~

### Die eigentliche Anfrage

Für die Ausgabetabelle wollen wir den Titel des Filmes sowie den Namen des Regisseurs und der Schauspieler angeben. Als Auswahlkriterium für den Film haben wir die ID bereits vorgegeben. Wir können zum Einstieg den Titel eines bestimmten Filmes ausgeben.

~~~~{.SQL}
SELECT titel FROM film WHERE id=<FILM_ID>;
~~~~

Mit Hilfe der Filmtabelle bekommen wir nur die Mitgliedsnummer des Regisseurs heraus, wir müssen die Filmschaffendentabelle noch konsultieren, um an den vollständigen Namen heranzukommen. Dazu wählen wir jene beide Tabellen aus; das Kriterium bzgl. der Film-ID bleibt bestehen. Als weiteres Kriterium müssen wir noch fordern, dass der Wert des Regisseurs aus der Film-Tabelle mit der Mitgliedsnummer übereinstimmt.

~~~~{.SQL}
SELECT titel,vorname,name FROM film, filmschaffende where id=<FILM_ID> AND regisseurin=mitgliedsnummer;
~~~~

Die Schauspieler erhalten wir nur in Kombination mit der Rollentabelle und den Filmschaffenden. Auch hier müssen die IDs wieder enstprechend übereinstimmen. Des Weiteren muss die Verbindung zwischen der Rolle und dem Film gewährleistet werden, das Attribut `film_id` in der Rollentabelle muss der Film-`id` entsprechen. Da wir die vorherige Anfrage wieder übernehmen werden, haben wir zweimal die gleiche Tabelle (Filmschaffende) in der Tabelle. Daher müssen wir mittels Aliasnamen arbeiten, um die Eindeutigkeit der Attribute zu gewährleisten. Die Filmschaffendetabelle, die wir für den Regisseur benötigen, nennen wir `r` und die andere benennen wir mit `s` (für Schauspieler). Damit ergibt sich abschließend folgende Anfrage.

~~~~{.SQL}
SELECT titel,r.vorname,r.name,s.vorname,s.name FROM film, filmschaffende where id=<FILM_ID> AND regisseurin=mitgliedsnummer AND film_id=id AND rolle.mitgliedsnummer=s.mitgliedsnummer;
~~~~

Sollten wir anstatt der ID nur den Titel des Filmes zur Verfügung haben, müssen wir den Titel entsprechend setzen.

~~~~{.SQL}
SELECT titel,r.vorname,r.name,s.vorname,s.name FROM film, filmschaffende where titel=<FILM_TITEL> AND regisseurin=mitgliedsnummer AND film_id=id AND rolle.mitgliedsnummer=s.mitgliedsnummer;
~~~~

Die Anfragen können wir nun noch in Abhängigkeit des Attributes (<ID> oder <TITEL>) nun wie folgt in Ruby programmieren.

~~~~{.ruby}
def query_reg_and_actors_by_id(db,movie_id)
  db.execute("SELECT titel,r.vorname,r.name,s.vorname,s.name FROM
                film, rolle, filmschaffende AS s, filmschaffende AS r
              WHERE film_id=" + movie_id.to_s + " AND rolle.mitgliedsnummer=s.mitgliedsnummer
                AND id=" + movie_id.to_s + "
                AND regisseurin=r.mitgliedsnummer;");
end;

def query_reg_and_actors_by_name(db,movie_name)
  db.execute("SELECT titel,r.vorname,r.name,s.vorname,s.name FROM
               film,rolle,filmschaffende AS s,filmschaffende AS r
              WHERE film_id=id AND rolle.mitgliedsnummer=s.mitgliedsnummer
                AND titel='" + movie_name + "'
                AND regisseurin=r.mitgliedsnummer;");
end;
~~~~

### Ausgabe der Tabelle in Ruby

Die Anfrage gibt nun vor, dass die Datensätze (inneres Array des zweidimensionalen Tabellenarrays) in der folgenden Form zurückgegeben werden:

~~~{.ruby}
[<FILM_TITEL>,<R.VORNAME>,<R.NACHNAME>,<S.VORNAME>,<S.NACHNAME>]
~~~~

Für die Ausgabe müssen wir die Reihenfolge im Hinterkopf behalten. Sollten in der Datenbank mehrere Schauspieler für einen Film gefunden werden, haben wir mehrere solcher Datensätze im Array. Um also alle Schauspieler zu erhalten müssen wir alle Datensätze durchgehen; der Titel des Filmes sowie die Daten zum Regisseur bleiben jedoch in allen weiteren Datensätze gleich. Der folgende Code gibt die Informationen wie folgt aus:

~~~~{.ruby}
Filmtitel
    <TITEL>
Regisseur
    <VORNAME> <NACHNAME>
Schauspieler
    <VORNAME> <NACHNAME>
    <VORNAME> <NACHNAME>
    ...
~~~~

~~~~{.ruby}
  table = query_menu(db);
  tab_width = 4;
  tab_string = " ".*(tab_width);
  if table == [] then
    puts("Die Suche ergab leider keine Treffer in der Datenbank.");
  else
    puts("");
    puts("Filmtitel\n" + tab_string + table[0][0]);
    puts("Regisseur\n" + tab_string + table[0][1] + " " + table[0][2]);
    puts("Schauspieler\n");
    for i in 0..table.size-1 do
      puts(tab_string + table[i][3] + " " + table[i][4]);
    end;
  end;
~~~~

Die Einrückungstiefe für die Daten aus der Tabelle wird dabei über `tab_width` variabel gehalten. Die Variable `table` wird dabei anhand der zuvor definierten Anfragemenü-Hilfsfunktion mit einem Wert belegt.

Das gesamte Programm kann in Tab **(e)** angeschaut werden; dort findet man auch ein Menü, dass zwischen der Suche nach ID und Titel unterscheidet.
