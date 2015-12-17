# Language: Ruby, Level: Level 4
require "csv"

# write a two-dimensional array (a tabular)
# as csv-value to file filename
def csv_write(filename,a)
  csv_str = "";
  for i in 0..a.size-1 do
    for j in 0..a[i].size-2 do
      csv_str = csv_str + "\"" + a[i][j].to_s + "\","
    end;
    csv_str = csv_str + "\"" + a[i][j+1].to_s + "\"\n";
  end;
  File.write(filename,csv_str);
end;

# read csv-file from filename and return its value
# as a two-dimensional array
def csv_read(filename)
  return CSV.read(filename)
end;

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
      puts(mask[j] + ": " + (if j==special_pos then "\n" else "" end) + table[i][j])
    end
    puts("----------------------------")
  end
end

# Main program
main_menue = ["Empfangene Nachrichten anzeigen",
              "Gesendete Nachrichten anzeigen",
              "Nachricht senden",
              "Nachricht empfangen",
              "Konversation mit Person zeigen",
              "Nachricht loeschen",
              "Nachricht weiterleiten",
              "Beenden"]


# if the following files do not exist, create
# empty files for thees.
sent_file = "sent.csv"
received_file = "received.csv"
sent = csv_read(sent_file)
received = csv_read(received_file)

choice = menue(main_menue)
while choice!=main_menue.size do
  case choice
  when 1 # show received messages
    pretty_print(["Von","Um","Das"],received,2)
  when 2 # show sent messages
    pretty_print(["An","Um","Das"],sent,2)
  when 3 # send a message
    print("An wen willst du eine Nachricht schicken? ")
    name = gets.chop
    puts("Was willst du " + name + " schreiben? ")
    input = ""
    text = gets
    while text!="\n" do
      input = input + text
      text = gets
    end;
    sent = sent + [[name,Time.now.to_s,input]]
    csv_write(sent_file,sent)
  when 4
    print("Wer hat dir geschrieben? ")
    name = gets.chop
    puts("Was hat " + name + " geschrieben? ")
    input = ""
    text = gets
    while text!="\n" do
      input = input + text
      text = gets
    end;
    received = received + [[name,Time.now.to_s,input]]
    csv_write(received_file,received)
  when 5
  when 6
  when 7
    print("An wen möchtest du eine Nachricht weiterleiten? ");
    name = gets.chop;
    puts("Welche Art von Nachricht möchtest du weiterleiten?");
    menuIdx = menue(["Gesendet","Empfangen"]);
    msgs = [];
    case menuIdx
    when 1
      msgs = sent;
    when 2
      msgs = received;
    else
      puts "unexpected input"
    end;

    puts("Welche Nachricht möchtest du an " + name + " weiterleiten?");

    msgs2 = []
    for i in 0..msgs.size-1 do
      msgs2 = msgs2 + [msgs[i][2]];
    end;
    msgIdx = menue(msgs2) - 1;
    fwdName = msgs[msgIdx][0];
    fwdTime = msgs[msgIdx][1];
    fwdMsg = msgs[msgIdx][2]
    input = "FWD von " + fwdName + " um " + fwdTime + "\n" + fwdMsg;
    sent = sent + [[name,Time.now.to_s,input]];
    csv_write(sent_file,sent);
  else
    puts("unexpected input");
  end;
  choice = menue(main_menue);
end;
