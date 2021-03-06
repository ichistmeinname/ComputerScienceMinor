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

# Main program
main_menue = ["Empfangene Nachrichten anzeigen",
              "Gesendete Nachrichten anzeigen",
              "Nachricht senden",
              "Nachricht empfangen",
              "Nachricht weiterleiten",
              "Nachricht loeschen",
              "Konversation mit Person zeigen",
              "Nachricht loeschen",
              "Beenden"]

use_database("../chat.db") do |db|

# if the following tables do not exist, create them
db.execute("CREATE TABLE IF NOT EXISTS nachrichten (id INTEGER PRIMARY KEY,
            zeit DATETIME, text TEXT, sender_id INTEGER,
            empfaenger_id INTEGER);")
db.execute("CREATE TABLE IF NOT EXISTS personen (id INTEGER PRIMARY KEY,
            name Text, vorname TEXT);")
db.execute("CREATE TABLE IF NOT EXISTS gruppen (id INTEGER PRIMARY KEY,
                    name Text);")

eigene_id = nil
while eigene_id == nil do
  puts("Bitte gib deine Kontaktdaten ein.")
  print("Name: ")
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

puts(eigene_id)

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
    print("Name: ")
    name = gets.chop
    print("Vorname: ")
    vorname = gets.chop
    other_id = personen_id(db,name,vorname)
    if other_id==nil then
      puts("Dieser Kontakt ist nicht bekannt.")
    else
      puts("Was willst du " + vorname + " " + name + " schreiben? ")
      input = ""
      text = gets
      while text!="\n" do
        input = input + text
        text = gets
      end
      db.execute("INSERT INTO nachrichten
                  (zeit,text,sender_id,empfaenger_id) VALUES
                  (datetime('now'),'"+input+"',"+eigene_id.to_s+","+
                  other_id.to_s+");")
    end

  when 4 # Nachricht empfangen

  when 5 # Nachricht weiterleiten

  when 6 # Nachricht löschen

  end
  choice = menue(main_menue)
end
end
