# Language: Ruby, Level: Level 4
# Alle Aufgabenteile

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

# Yields the given array with an
#  additional entry (a new message)
#  and writes the change into the given
#  CSV-file
def send_message(file,arr,name,msg)
  arr = arr + [[name,Time.now.to_s,msg]];
  csv_write(file,arr);
  return arr;
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

# Yields a new array that consists
#  only of the entries in column `col`
#  of the original array `arr`
def mapMessages_column(arr,col)
  msgs = []
  for i in 0..arr.size-1 do
    msgs = msgs + [arr[i][col]];
  end;
  return msgs;
end;

# Yields an array that consists only of the
#  of the original array that have the value `val`
#  in column `col`
def filter_column_with_value(arr,val,col)
  msgs = [];
  for i in 0 .. arr.size-1 do
    colVal = arr[i][col];
    if colVal == val then
      msgs = msgs + [arr[i]];
    end;
  end;
  return msgs;
end;

# Filters the given message array
#  by sender or receiver name
def search_person(arr,person)
  return filter_column_with_value(arr,person,0);
end;

# Sent and received messages are sorted
#  chronologically and marked with extra information
def sort_messages(sentArr,recArr)
  allMsgs = [];
  i = 0;
  j = 0;
  while i < sentArr.size || j < recArr.size do
    if i >= sentArr.size then
      # sent messages are marked with a "rec"-entry
      allMsgs = allMsgs + [["rec"] + recArr[j]];
      j = j + 1;
    else
      if j >= recArr.size then
        # received messages are marked with a "sent"-entry
        allMsgs = allMsgs + [["sent"] + sentArr[i]];
        i = i + 1;
      else
        if sentArr[i][1] < recArr[j][1] then
          allMsgs = allMsgs + [["sent"] + sentArr[i]];
          i = i + 1;
        else
          allMsgs = allMsgs + [["rec"] + recArr[j]];
          j = j + 1;
        end;
      end;
    end;
  end;
  return allMsgs;
end;

# Prints an array that is marked with
#  additional information about
#  sent/received messages,
#  the sent messages are printed normally (left)
# The given array has the following scheme:
# [[<"rec"|"sent">,<Name>,<Time>,Msg]]
def print_conversation(convArr,width)
  for i in 0..convArr.size-1 do
    if convArr[i][0] == "rec" then
      puts(convArr[i][1] + " schreibt:");
      puts(convArr[i][3]);
    else
      puts("Ich schreibe:")
      # Or use globally defined variable instead
      # puts(userName + " schreibt:");
      puts(convArr[i][3].to_s);
    end;
  end;
end;

# Alternative version for `print_conversation`:
# All received messages are printed
#  with right alignment
#  (with respect to the given lineWidth)
# More precisely, only the actual text-messages
#  are printed, all other information is discarded
def print_pretty_conversation(convArr,width)
  for i in 0..convArr.size-1 do
    if convArr[i][0] == "rec" then
      puts(convArr[i][3].to_s.rjust(width));
    else
      puts(convArr[i][3].to_s);
    end;
  end;
end;

# Removes the element on `idx`th position in `arr`
def remove_at(arr,idx)
  return arr[0,idx] + arr[idx+1,arr.size-idx-1];
end;


# !!!!!!!!!!!! Für Aufgabenteil (c) !!!!!!!!!!!!
# Prints the message array (with help of pretty_strings)
#  in groups of `boundStep` messages
# After `boundStep` messages, the user can chose to
#  display more messages or to close the menu.
def print_messages(msgArr,labels,boundStep)
  # Produce array of strings for the menu
  strArr = pretty_strings(labels,msgArr,2);
  # start index position of the current block
  boundStart = 0;
  # end index position of current block
  boundEnd = boundStart + boundStep;
  # user's choice (0 = more, 1 = stop)
  recChoice = 0;
  while recChoice == 0 do
    # print the next `boundStep` messages
    puts(strArr[boundStart,boundStep]);
    # check if we have to show an additional menu
    if strArr.size > boundEnd then
      # show an additional menu
      recChoice = menue(["Mehr anzeigen","Beenden"]) - 1;
      # update bounds for the second round of messages
      boundStart = boundEnd;
      boundEnd = boundEnd + boundStep;
    else
      # otherwise set `recChoice` to 1 in order to stop looping
      recChoice = 1;
    end;
  end;
end;

# Yields and array of strings that correspond to
# entries of a table with labels from the mask.
# The column specified as special_pos is formatted
# underneath the label from the mask.
def pretty_strings(mask, table, special_pos)
  pretty_strings = [];
  for i in 0..table.size-1 do
    string = "";
    for j in 0..mask.size-1 do
      string = string + mask[j] + ": " + (if j==special_pos then "\n" else "" end) + table[i][j] +"\n";
    end;
    string = string + "----------------------------";
    pretty_strings = pretty_strings + [string];
  end;
  return pretty_strings;
end;

# Yields an array of pretty strings for received messages
def pretty_strings_rec(recArr)
  return pretty_strings(["Von","Um","Das"],recArr,2);
end;

# Yiels an array of pretty strings for sent messages
def pretty_strings_sent(sentArr)
  return pretty_strings(["An","Um","Das"],sentArr,2);
end;

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
# empty files for these.
sent_file = "sent.csv"
received_file = "received.csv"
sent = csv_read(sent_file)
received = csv_read(received_file)

# Store the user's name globally at the beginning of a session
print("Wie ist dein Name? ");
userName = gets.chop;
# terminal's line width, we need this value for pretty printing
#  a conversation
lineWidth = 80;

choice = menue(main_menue)
while choice!=main_menue.size do
  case choice
  when 1 # show received messages
    print_messages(received,["Von","Um","Das"],5);
  when 2 # show sent messages
    print_messages(sent,["An","Um","Das"],5);
  when 3 # send a message
    print("An wen willst du eine Nachricht schicken? ")
    name = gets.chop
    puts("Was willst du " + name + " schreiben? ")
    input = gets_message;
    sent = send_message(sent_file,sent,name,input);
  when 4
    print("Wer hat dir geschrieben? ")
    name = gets.chop
    puts("Was hat " + name + " geschrieben? ")
    input = gets_message;
    received = received + [[name,Time.now.to_s,input]]
    csv_write(received_file,received)
  when 5
    # !!!!!!!!!!!! Aufgabenteil (a) !!!!!!!!!!!!
    print("Für welche Person möchtest du dir deinen Nachrichtenverlauf anschauen? ");
    # Name to search for in saved conversations
    name = gets.chop;

    # collect the messages that were sent to or from the given name
    sentMsgs = search_person(sent,name);
    recMsgs  = search_person(received,name);

    # Sort the messages chronologically
    chronMsgs = sort_messages(sentMsgs,recMsgs);

    # Print the messages
    if chronMsgs.size == 0 then
      puts("Du hast leider keinerlei Konversationen mit " + name + ".\n");
    else
      puts("Konversationen mit " + name);
      # print_conversation uses `lineWidth`
      #  to right justify your partner's
      #  messages
      print_pretty_conversation(chronMsgs,lineWidth);
      puts("\n--------------------------\n");
    end;
  when 6
    # !!!!!!!!!!!! Aufgabenteil (b) !!!!!!!!!!!!
    puts("Möchtest du eine gesendete oder empfangene Nachricht löschen?");

    # Collect all messages
    msgs = sent + received;

    # Get arrays of strings for sent and received messages,
    #  concatenate these arrays
    msgsMenu = pretty_strings_sent(sent) + pretty_strings_rec(received);
    # Use Arrays of message-strings as menue
    #  and save user's choice in `msgIndex`
    # The actual index position and menu number are out
    #  of synch, so it is necessary to decrement the index value
    msgChoice = menue(msgsMenu) - 1;

    # Does the chosen index correspond to
    #  a sent or received message?
    # We have to remove the entry in the
    #  corresponding array and write
    #  the array to an csv-file again.
    if msgChoice < sent.size then
      sent = remove_at(sent,msgChoice);
      csv_write(sent_file,sent);
    else
      msgChoice = msgChoice - sent.size;
      received = remove_at(received,msgIndex);
      csv_write(received_file,received);
    end;
  when 7
    puts("Welche Nachricht möchtest du weiterleiten?");
    # Creates an array with all values of the
    #  second column of the arrays `received` and `sent`
    msgs = sent + received;

    # Prints the menu to chose a message and yields
    #  the chosen index
    msgsMenu = pretty_strings_sent(sent) + pretty_strings_rec(received);
    msgChoice = menue(msgsMenu) - 1;

    # Set message's text to chosen text with an additonal
    #  "FWD: "-prefix
    message = "FWD Nachricht von ";
    # Concatenate name of original sender
    if msgChoice < sent.size then
      message = message + userName
    else
      message = message + msgs[msgChoice][0];
    end;
    # Add time-stamp in message
    message = message + " um " + msgs[msgChoice][1];
    # as well as the original text
    message = message + "\n>>" + msgs[msgChoice][2] + "<<";

    puts("An wen möchtest du die Nachricht weiterleiten?");
    # receiver's name
    name = gets.chop;

    sent = send_message(sent_file,sent,name,message);
  end;
  choice = menue(main_menue);
end;
