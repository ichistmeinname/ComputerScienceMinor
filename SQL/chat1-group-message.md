Das Grundmenü soll unterscheiden, ob an eine bestehende oder neue Gruppe gesendet werden soll. Wir können die Hauptschleife schon einmal anlegen und die einzelnen Bestandteile danach im Detail anschauen. Im `else`-Fall wird eine Fehlerausgabe gemacht und der Benutzer wird erneut aufgefordert eine (sinnvolle) Eingabe zu tätigen.
Des Weiteren können wir uns schon einmal festhalten, dass wir am Ende eine Nachricht an eine Gruppe von Personen schreiben sollen. Also legen wir bereits fest, dass aus beiden Zweigen als Seiteneffekt ein gefülltes Array `persons_arr` mit den entsprechenden Personen herauskommen soll. An die Personen in diesem Array können wir dann jeweils eine Nachricht schreiben, die wir den Benutzer eingeben lassen.

~~~~{.ruby}
    when 7
      print("Soll an eine (n)eue oder (b)estehende Gruppe gesendet werden? ");

      choice = gets.chop;
      choice_loop = true;

      while choice_loop do
        case choice
        when "b","B"
          choice_loop = false;
          ...

        when "n","N"
          choice_loop = false;
          ...

        else
          puts("Ungültige Eingabe, wiederhole deine Eingabe!");
          print("Soll an eine (n)eue oder (b)estehende Gruppe gesendet werden?");
          choice = gets.chop;
        end;
      end;

      puts("Geben Sie die gewünschte Nachricht ein.");
      msg = gets_message();
      # send the message to each member of the group
      for i in 0..persons_arr.size-1 do
        send_message(db,eigene_id,persons_arr[0],msg);
      end;
~~~~

Die Hilfsfunktionen `gets_message()` ist bereits aus dem Chat bekannt, während `send_message` die angepasste Hilfsfunktion zum Verschicken einer Nachricht ist.

~~~~{.ruby}
def gets_message()
  input = "";
  text = gets;
  while text!="\n" do
    input = input + text;
    text = gets;
  end;
  # Get rid of last `\n`
  return input.chop;
end;

def send_message(db,sender_id,receiver_id,msg)
  db.execute("INSERT INTO nachrichten
              (zeit,text,sender_id,empfaenger_id) VALUES
              (datetime('now'),'"+msg+"',"+sender_id.to_s+","+
              receiver_id.to_s+");");
end;
~~~~

Im Falle einer Gruppennachrichten an eine bestehende Gruppen, geben wir ein Menü für die vorhanden Gruppenname aus, aus denen der Benutzer die Empfängergruppe wählt. Die Gruppennamen erhalten wir über eine einfache Anfrage an die Datenbank.

~~~~{.SQL}
SELECT name FROM gruppen;
~~~~

Wenn der Benutzer eine Gruppe gewählt hat, benötigen wir die Mitglieder dieser Gruppe. Dazu schreiben wir eine weitere SQL-Anfrage, die anhand der Personen, Gruppen und Mitgliedschaften über den Gruppennamen und die ID-Zuordnung zwischen der Gruppe und Mitgliedschaften sowie Person unt Mitgliedschaften, ein Tabelle mit den Personen-`id`s der Gruppenmitglieder zurückgibt.

~~~~{.SQL}
SELECT personen.id FROM personen, gruppen, mitgliedschaften
  WHERE gruppen.name= <GRUPPEN_NAME>
   AND gruppen.id=gruppen_id
   AND personen.id=personen_id;
~~~~

Diese Anfragen können wir nun innerhalb unseres Programms verwenden, um ein gefülltes Personenarray zu erstellen.

~~~~{.ruby}
        ...
        when "b","B"
          choice_loop = false;
          group_table = db.execute("SELECT name FROM gruppen;");
          group_choice = menue(group_table) - 1;
          group_name = group_table[group_choice];
          persons_arr = db.execute("SELECT personen.id FROM personen, gruppen, mitgliedschaften
                                    WHERE gruppen.name='" + group_name + "' AND gruppen.id=gruppen_id
                                    AND personen.id=personen_id;");

~~~~

Für den Fall einer neuen Gruppe müssen wir uns die Namen der Personen geben lassen und diese in ein Array von Namen umwandeln. Die allgemeine Funktion `namelist_to_array` sammelt dabei zwei Einträge (Vor- und Nachname) innerhalb des regulären Ausdrucks für die Namensliste auf. Dabei entsteht ein zweidimensionales Array, dessen inneres Array in der ersten Komponente den Vornamen und in der zweiten Komponente den Nachnamen hält. Der reguläre Ausdruck matcht dann zwei mal auf eine Folge von Buchstaben (mittels Leerzeichen getrennt) und ein optionales Komma am Ende -- dieser Ausdruck ist nicht sehr präzise, reicht für unsere Konvention aber aus (problematisch sind z.B. Doppelnamen ohne Bindestrich).

~~~~{.ruby}
def namelist_to_array(str,regexp)
  names_arr = [];
  match_obj = regexp.match(str);
  while match_obj != nil do
    puts(match_obj);
    names_arr = names_arr + [match_obj[1].to_s, match_obj[2].to_s];
    match_obj = regexp.match(match_obj.post_match);
  end;
  return names_arr;
end;

def gets_names_array
  names = gets.chop;
  names_regexp = /([A-Z]([a-z]*)) ([A-Z]([a-z]*))(,?)/;
  return namelist_to_array(names,names_regexp);
end;
~~~~

Wir können nun schon folgenden Rahmen für den zweiten Fall anlegen. Danach schauen wir uns an, wie wir einmalig die neue Gruppe sowie die Mitgliedschaften für alle angegebenen Personen anlegen.

~~~~{.ruby}
        ...
        when "n","N"
          choice_loop = false;

          puts("Wie soll die neue Gruppe heißen?");
          group_name = gets.chop;

          puts("Wer soll der Gruppe " + group_name + " angehören? Geben Sie die Namen (Vorname Nachname) mit Komma getrennt an.");
          names_arr = gets_names_array;

          for i in 0..names_arr.size-1 do
            # lege Gruppe sowie alle Mitgliedschaften an
          end;
~~~~

Zunächst müssen wir überprüfen, ob die angegebene Person überhaupt in der Datenbank vorhanden ist. Wenn nicht, ignorieren wir der Einfachheit halber den Namen. Haben wir einen Datensatz gefunden, benötigen wir die ID, um die Mitgliedschaft einzutragen. Für die Mitgliedschaft benötigen wir jedoch auch die Gruppen-ID; dazu legen wir beim ersten erfolgreich gefundenen Datensatz einer Person auch die neue Gruppe an und schlagen die neue ID nach. Danach können wir die Mitgliedschaft in der Datenbank eintragen.

Analog zu `personen_id` legen wir eine Hilfsfunktion an, die eine Gruppen-ID zu einem gegebenen Namen nachschlägt. Im Falle von Mehrfacheinträgen wollen wir den letzten, sprich neusten, Datensatz. Da wir in unserem Anwendungsfall ja gerade eine neue Gruppe mit dem Namen angelegt haben. (_Hinweis: Das ist von der Datenbank nicht gut gelöst, eigentlich möchte man nach dem Anlegen eines neuen Datensatzes die resultierende ID direkt zurückbekommen und nicht erst durch eine weitere Anfrage._)

~~~~{.ruby}
def gruppen_id(db,name,vorname)
  t = db.execute("SELECT id FROM gruppen WHERE name='"+name+"';");
  if t==[] then
    return nil;
  else
    # If the name isn't unique, we want the last (newest) entry.
    return t[t.size-1][0];
  end;
end;
~~~~

Die Einfüge-Anfragen für die neue Gruppen und Mitgliedschaften sehen wie folgt aus.

~~~~{.SQL}
INSERT INTO gruppen (name) VALUES (<GRUPPEN_NAME>);
INSERT INTO mitgliedschaften VALUES (<GRUPPEN_ID>,<PERSONEN_ID>);
~~~~

Mit diesen Überlegungen, Hilfsfunktionen und Anfragen in der Hinterhand können wir das Programm wie folgt in Ruby fortsetzen.

~~~~{.ruby}
          ...
          for i in 0..names_arr.size-1 do
            id = personen_id(db,names_arr[i][1],names_arr[0]);
            if id == 0 then
              puts("Der Kontakt '" + names_arr[i][0] + " " + names_arr[i][1] + "' konnte nicht gefunden werden.");
            else
              group_id = nil;
              # The first found contact triggers that the group is acutally created
              if group_id == nil then
                db.execute("INSERT INTO gruppen (name) VALUES ('" + group_name + "');");
                group_id = gruppen_id(db,group_name);
              end;

              # The connection between the person and the group is created
              db.execute("INSERT INTO mitgliedschaften VALUES (" + group_id.to_s + "," + id.to_s + ");");
              persons_arr = persons_arr + [id];
            end;
          end;
~~~~

Der gesamte Code kann wie gewohnt im nächsten Tab begutachtet werden.
