# Language: Ruby, Level: Level 4
require_relative "../sqlite_connector"

def menue(items)
  n = 0
  while n<1 || n>items.size do
    for i in 0..items.size-1 do
      puts("(" + (i+1).to_s + ") " + items[i])
    end
    print("Deine Wahl: ")
    n = gets.to_i
  end
  return n
end

# Print entries of a table with labels from the mask.
# The column specified as special_pos is printed
# underneath the label from the mask.
def pretty_print(mask, table, special_pos)
  for i in 0..table.size-1 do
    for j in 0..mask.size-1 do
      puts(mask[j] + ": " + (if j==special_pos then "\n" else "" end) + table[i][j].to_s)
    end
    puts("----------------------------")
  end
end

# function to lookup the id of a personen_id
# returns nil if the person does not exist
def personen_id(db,name,vorname)
  t = db.execute("SELECT id FROM personen WHERE name='"+name+
                 "' AND vorname='"+vorname+"';")
  if t==[] then
    return nil
  else
    return t[0][0]
  end
end

# function to lookup the id of a gruppen_id
# returns nil if the group does not exist
def gruppen_id(db,name,vorname)
  t = db.execute("SELECT id FROM gruppen WHERE name='"+name+"';");
  if t==[] then
    return nil;
  else
    # If the name isn't unique, we want the last (newest) entry.
    return t[t.size-1][0];
  end;
end;

# Needs a database as argument to execute SQL-commands
def setup(db)
  # if the following tables do not exist, create them
  db.execute("CREATE TABLE IF NOT EXISTS nachrichten (id INTEGER PRIMARY KEY,
              zeit DATETIME, text TEXT, sender_id INTEGER,
              empfaenger_id INTEGER);")
  db.execute("CREATE TABLE IF NOT EXISTS personen (id INTEGER PRIMARY KEY,
              name Text, vorname TEXT);")
  db.execute("CREATE TABLE IF NOT EXISTS gruppen (id INTEGER PRIMARY KEY,
                      name Text);")
  db.execute("CREATE TABLE IF NOT EXISTS mitgliedschaften (gruppen_id INTEGER,
                      personen_id INTEGER);");

  # fill database with dummy persons, if no data exists
  if db.execute("SELECT * FROM personen;") == [] then
    db.execute("INSERT INTO personen (name,vorname) VALUES ('Dylus','Sandra');");
    db.execute("INSERT INTO personen (name,vorname) VALUES ('Huch','Frank');");
    db.execute("INSERT INTO personen (name,vorname) VALUES ('Kirchmayr','Bastian');");
  end;

  # fill database with dummy groups, if no data exists
  if db.execute("SELECT * FROM gruppen;") == [] then
    db.execute("INSERT INTO gruppen (name) VALUES ('Mitarbeiter');");
    db.execute("INSERT INTO gruppen (name) VALUES ('Hiwis');");
  end;

  # fill database with dummy memberships, if no data exists
  if db.execute("SELECT * FROM mitgliedschaften;") == [] then
    db.execute("INSERT INTO mitgliedschaften (gruppen_id,personen_id) VALUES (1,1);");
    db.execute("INSERT INTO mitgliedschaften (gruppen_id,personen_id) VALUES (1,2);");
    db.execute("INSERT INTO mitgliedschaften (gruppen_id,personen_id) VALUES (2,3);");
  end;

end;

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

# Yields a text-message that is
#  entered by the user;
#  '\n' as an single input can be
#  used to end the message
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

# Main program
main_menue = ["Empfangene Nachrichten anzeigen",
              "Gesendete Nachrichten anzeigen",
              "Nachricht senden",
              "Nachricht empfangen",
              "Nachricht weiterleiten",
              "Nachricht loeschen",
              "Gruppennachricht verschicken",
              "Beenden"]

use_database("../chat.db") do |db|

setup(db);

eigene_id = nil
while eigene_id == nil do
  puts("Bitte gib deine Kontaktdaten ein.")
  print("Nachname: ")
  eigener_name = gets.chop
  print("Vorname: ")
  eigener_vorname = gets.chop
  eigene_id = personen_id(db,eigener_name,eigener_vorname)
  if eigene_id==nil then
    puts("Diese Person existiert noch nicht.")
    print("Soll sie angelegt werden (j/n)?")
    choice = gets.chop
    if choice == "j" then
      db.execute("INSERT INTO personen (name,vorname) VALUES
                  ('"+eigener_name+"','"+eigener_vorname+"');")
      eigene_id = personen_id(db,eigener_name,eigener_vorname)
    end
  end
end

puts("Du hast die ID " + eigene_id.to_s + ".");

choice = menue(main_menue)
while choice!=main_menue.size do
  case choice
  when 1 # show received messages
    received = db.execute("SELECT vorname,name,zeit,text FROM nachrichten,personen
                           WHERE empfaenger_id="+eigene_id.to_s+" AND
                           sender_id=personen.id;")
    pretty_print(["Vorname","Name","Um","Das"],received,3)
  when 2 # show sent messages
    sent     = db.execute("SELECT vorname,name,zeit,text FROM nachrichten,personen
                           WHERE sender_id="+eigene_id.to_s+" AND
                           empfaenger_id=personen.id;")
    pretty_print(["Vorname","Name","Um","Das"],sent,3)
  when 3 # send a message
    puts("An wen willst du eine Nachricht schicken? ")
    print("Nachname: ")
    name = gets.chop
    print("Vorname: ")
    vorname = gets.chop
    other_id = personen_id(db,name,vorname)
    if other_id==nil then
      puts("Dieser Kontakt ist nicht bekannt.")
    else
      puts("Was willst du " + vorname + " " + name + " schreiben? ")
      input = gets_message;
      send_message(db,eigene_id,other_id,input);
      # db.execute("INSERT INTO nachrichten
      #             (zeit,text,sender_id,empfaenger_id) VALUES
      #             (datetime('now'),'"+input+"',"+eigene_id.to_s+","+
      #             other_id.to_s+");")
    end

  when 4 # Nachricht empfangen
    puts("Wer hat dir geschrieben?")
    print("Nachname: ")
    name = gets.chop
    print("Vorname: ")
    vorname = gets.chop
    other_id = personen_id(db,name,vorname)
    if other_id==nil then
      puts("Dieser Kontakt ist nicht bekannt.")
    else
      puts("Was hat dir " + vorname + " " + name + " schreiben? ")
      input = ""
      text = gets
      while text!="\n" do
        input = input + text
        text = gets
      end
      send_message(db,other_id,eigene_id,input);
      # db.execute("INSERT INTO nachrichten
      #             (zeit,text,sender_id,empfaenger_id) VALUES
      #             (datetime('now'),'"+input+"',"+other_id.to_s+","+
      #             eigene_id.to_s+");")
    end
  when 5 # Nachricht weiterleiten
    print("Willst due eine (g)esendete oder eine (e)mpfangene "+
          "Nachricht weiterleiten? ")
    art = gets.chop
    if art=="g" then
      messages = db.execute("SELECT nachrichten.id,vorname,name,zeit,text FROM nachrichten,personen
                             WHERE sender_id="+eigene_id.to_s+" AND
                             empfaenger_id=personen.id;")
    else
      messages = db.execute("SELECT nachrichten.id,vorname,name,zeit,text FROM nachrichten,personen
                             WHERE empfaenger_id="+eigene_id.to_s+" AND
                             sender_id=personen.id;")
    end
    pretty_print(["Nummer","Vorname","Name","Um","Das"],messages,4)
    print("Welche Nachricht moechtest du weiterleiten? Bitte gib die Nummer an: ")
    msg_id = gets.to_i
    puts("An wen soll die Nachricht weiter geleitet werden?")
    print("Nachname: ")
    name = gets.chop
    print("Vorname: ")
    vorname = gets.chop
    other_id = personen_id(db,name,vorname)
    if other_id == nil then
      puts("Dieser Kontakt ist nicht bekannt.")
    else
      found = false
      i = 0
      while !found && i<messages.size do
        if messages[i][0]==msg_id then
          text = messages[i][4]
          found = true
        else
          i = i+1
        end
      end
      if !found then
        puts("Es gibt keine Nachricht mit dieser Nummer")
      else
        send_message(db,eigene_id,other_id,text);
        # db.execute("INSERT INTO nachrichten
        #             (zeit,text,sender_id,empfaenger_id) VALUES
        #             (datetime('now'),'"+text+"',"+eigene_id.to_s+","+
        #             other_id.to_s+");")
      end
    end
  when 6 # Nachricht löschen
    print("Willst due eine (g)esendete oder eine (e)mpfangene "+
          "Nachricht loeschen? ")
    art = gets.chop
    if art=="g" then
      messages = db.execute("SELECT nachrichten.id,vorname,name,zeit,text FROM nachrichten,personen
                             WHERE sender_id="+eigene_id.to_s+" AND
                             empfaenger_id=personen.id;")
    else
      messages = db.execute("SELECT nachrichten.id,vorname,name,zeit,text FROM nachrichten,personen
                             WHERE empfaenger_id="+eigene_id.to_s+" AND
                             sender_id=personen.id;")
    end
    pretty_print(["Nummer","Vorname","Name","Um","Das"],messages,4)
    print("Welche Nachricht moechtest du loeschen? Bitte gib die Nummer an: ")
    msg_id = gets.to_i
    db.execute("DELETE FROM nachrichten WHERE
                id="+msg_id.to_s+";")
    when 7
      print("Soll an eine (n)eue oder (b)estehende Gruppe gesendet werden? ");
      choice = gets.chop;
      choice_loop = true;
      persons_arr = [];
      while choice_loop do
        case choice
        when "b","B"
          choice_loop = false;
          group_table = db.execute("SELECT name FROM gruppen;");
          group_choice = menue(group_table) - 1;
          group_name = group_table[group_choice];
          persons_arr = db.execute("SELECT personen.id FROM personen, gruppen, mitgliedschaften
                                    WHERE gruppen.name='" + group_name + "' AND gruppen.id=gruppen_id
                                    AND personen.id=personen_id;");
        when "n","N"
          choice_loop = false;
          puts("Wie soll die neue Gruppe heißen?");
          group_name = gets.chop;
          puts("Wer soll der Gruppe " + group_name + " angehören? Geben Sie die Namen (Vorname Nachname) mit Komma getrennt an.");
          names_arr = gets_names_array;

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
    end;
    choice = menue(main_menue)
  end;
end
