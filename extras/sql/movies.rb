# Language: Ruby, Level: Level 4
require_relative "../sqlite_connector"

def setup(db)
 # if the following tables do not exist, create them
 db.execute("CREATE TABLE IF NOT EXISTS film (id INTEGER PRIMARY KEY,
             titel TEXT, erscheinungsjahr INTEGER, bewertung INTEGER, regisseurin INTEGER);")
 db.execute("CREATE TABLE IF NOT EXISTS filmschaffende (mitgliedsnummer INTEGER PRIMARY KEY,
             vorname Text, name TEXT, geburtsdatum DATETIME);")
 db.execute("CREATE TABLE IF NOT EXISTS rolle (film_id INTEGER,
                     mitgliedsnummer INTEGER);")
end;

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

def complex_query_menu(db)
  table = [];
  print("Wähle einen Film über seine (I)D oder seinen (T)itel: ");
  choice = gets.chop;
  choice_loop = true;
  while choice_loop do
    case choice
      when "I","i"
        print("Gebe die ID des Films ein: ");
        id = gets.chop.to_i;
        while id == 0 do
          puts("Inkorekte Eingabe; gebe die ID des Films ein: ");
          id = gets.chop.to_i;
        end;
        table = query_reg_and_actors_by_id(db,id);
        choice_loop = false;
      when "T","t"
        print("Gebe den Namen des Films ein: ");
        name = gets.chop;
        table = query_reg_and_actors_by_name(db,name);
        choice_loop = false;
      else
        puts("Inkorrekte Eingabe, wiederhole deine Eingabe.");
        print("Wähle einen Film über seine (I)D oder seinen (T)itel: ");
        choice = gets.chop;
      end;
  end;
  return table;
end;

def query_menu(db);
  print("Wähle einen Film über seine ID aus: ");
  id = gets.chop.to_i;
  while id == 0 do
    puts("Inkorekte Eingabe; gebe die ID des Films ein: ");
    id = gets.chop.to_i;
  end;
  table = query_reg_and_actors_by_id(db,id);

  return table;
end;

# Executes as SELECT-statement for the given database `db` for a specific `movie_id`
def query_reg_and_actors_by_id(db,movie_id)
  db.execute("SELECT titel,r.vorname,r.name,s.vorname,s.name FROM
                film, rolle, filmschaffende as s, filmschaffende as r
              WHERE film_id=" + movie_id.to_s + " AND rolle.mitgliedsnummer=s.mitgliedsnummer
                AND id=" + movie_id.to_s + "
                AND regisseurin=r.mitgliedsnummer;");
end;

# Executes as SELECT-statement for the given database `db` for a specific `movie_name`
def query_reg_and_actors_by_name(db,movie_name)
  db.execute("SELECT titel,r.vorname,r.name,s.vorname,s.name FROM
               film,rolle,filmschaffende as s,filmschaffende as r
              WHERE film_id=id AND rolle.mitgliedsnummer=s.mitgliedsnummer
                AND titel='" + movie_name + "'
                AND regisseurin=r.mitgliedsnummer;");
end;

use_database("../imdb") do |db|

  movie_scheme = ["titel","erscheinungsjahr","bewertung","regisseurin"];
  movie_table  = "film";
  role_scheme  = ["film_id","mitgliedsnummer"];
  role_table   = "rolle";
  cast_scheme  = ["vorname","name","geburtsdatum"];
  cast_table   = "filmschaffende";

  setup(db);
  # fill_database_with_movies(db);
  fill_database(db,movie_table,movie_scheme,movies_arr);

  # fill_database_with_cast(db);
  fill_database(db,cast_table,cast_scheme,cast_arr);

  # fill_database_with_roles(db);
  fill_database(db,role_table,role_scheme,roles_arr);

  # array for resulting sql-table
  # table = query_menu(db);
  table = complex_query_menu(db);

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
end;
