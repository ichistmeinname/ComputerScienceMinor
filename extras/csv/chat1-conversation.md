Als erstes werden wir überlegen, welche Funktionalitäten bzw. Hilfsfunktionen wir benötigen, um die Aufgabe zu erfüllen.

Wir müssen

* zwei sortiere Arrays so kombinieren, dass wieder ein sortiertes Array entsteht
* bestimmte Nachrichten nach dem Empfänger bzw. Sender filtern können
* den Nachrichtenverlauf benutzerfreundlich (sinnvoll und lesbar) auf der Konsole ausgeben


Im Folgenden werden wir erst einmal Funktionen (bzw. Prozeduren für die Ausgabe) schreiben, die diese Teilaufaben übernehmen.

Wir fangen damit an, zwei Nachrichtenarrays (die bereits chronologisch sortiert sind) so zusammenzufügen, dass alle Nachrichten chronologisch sortiert sind.
Nicht vergessen: die Nachrichtenarrays sind mehrdimensional. Jeder Eintrag des Arrays ist wiederum ein Array mit drei Einträgen (Name, Uhrzeit, Nachricht).

~~~~{.ruby}
# Combine two individually sorted two-dimensional arrays
#  in chronological order
# We assume here that the second inner array position
#  is the component that is compared (the timestamp)
def sort_arrays_chron(sentArr,recArr)
  # store sorted messages in new array
  allMsgs = [];
  # index position for sentArr
  i = 0;
  # index position for recArr
  j = 0;
  # as long as there elements we haven't looked at yet
  while i < sentArr.size || j < recArr.size do

    # if there are no elements left in sentArr
    if i >= sentArr.size then
      # add the next message from recArr
      allMsgs = allMsgs + [recArr[j]];
      # increment the index position for recArr
      j = j + 1;
    else
      # if there are not elements left in recArr,
      #  we behave analogue to above
      if j >= recArr.size then
        allMsgs = allMsgs + [sentArr[i]];
        i = i + 1;
      else
        # if both arrays still have element left,
        #  we add the next element depending on
        #  the (smaller) timestamp
        if sentArr[i][1] < recArr[j][1] then
          allMsgs = allMsgs + [sentArr[i]]];
          i = i + 1;
        else
          allMsgs = allMsgs + [recArr[j]];
          j = j + 1;
        end;
      end;
    end;
  end;

  # We yield the chronologically sorted messages.
  return allMsgs;
end;
~~~~

Als nächstes kümmern wir uns darum, nach Nachrichten einer bestimmen Person zu suchen. Wir wissen dabei, dass der Name der Person jeweils an der ersten Stelle (Indexposition 0) aufgeführt ist.

~~~~{.ruby}
def search_person(arr,person)
  # new array with messages associcated with `person`
  msgs = [];

  # iterate all messages
  for i in 0..arr.size - 1 do
  	cur_name = arr[i][0];

    # if we see the name we search for ...
    if cur_name == person then
      # ... add the entire message array
      msgs = msgs + [arr[i]];
    end;
  end;

  # We yield the filtered messages associated with `person`.
  return msgs;
end;
~~~~

Da die grundlegende Idee der Funktion eigentlich viel allgemeiner Natur ist, nehmen wir uns einmal kurz die Zeit, die Funktion umzuschreiben. Wir können ein weiteres Argument übergeben, anhand dessen wir entscheiden, welche Indexposition mit dem übergebenen Wert verglichen werden sollen. Damit können wir die entstehende Funktion allgemein für zwei-dimensionale Arrays verwenden und haben damit nicht nur eine anwendungsspezifische Funktion geschrieben.

~~~~{.ruby}
def filter_column_with_value(arr,val,col)
  filtered_array = [];

  # iterate all messages
  for i in 0..arr.size - 1 do
    # Select `col`th element from the inner array
  	col_val = arr[i][col];

    # if we see the value we search for...
    if cur_val == val then
      # ... add the array
      filtered_array = filtered_array + [arr[i]];
    end;
  end;

  # We yield the filtered array
  return filtered_array;
end;
~~~~

Mit dieser Hilfsfunktion können wir unsere spezielle Funktion `search_person` wie folgt implementieren.

~~~~{.ruby}
def search_person(arr,person)

  return filter_column_with_value(arr,person,0);

end;
~~~~

Zu guter Letzt wollen wir noch die entsprechenden Nachrichten ausgeben.

~~~~{.ruby}
# first idea
def print_conversation(convArr)

  # Print the elements of the inner array
  #  with the following scheme:
  #
  # Frank schreibt:
  # Hallo Sandra!
  #
  # Sandra schreibt:
  # Hallo zurück!
  #
  for i in 0..convArr.size-1 do
    puts(convArr[i][0] + " schreibt:");
    puts(convArr[i][2] + "\n");
  end;

end;
~~~~

Jetzt wollen wir die Einzelteile endlich mal zusammenfügen und die eigentliche Funktionalität implementieren.


~~~~{.ruby}
...
when 5
  print("Für welche Person möchtest du dir deinen Nachrichtenverlauf anschauen?"
  # name to search for in saved conversations
  name = gets.chop

  # collect messages that were sent to or by the given name
  sentMsgs = search_person(sent,name);
  recMsgs  = search_person(received,name);

  # sort the messages chronologically
  chronMsgs = sort_arrays_chron(sentMsgs,recMsgs);

  # Print the messages
  if chronMsgs.size == 0 then
    puts("Du hast leider keinerlei Nachrichten mit " + name + " ausgetauscht.\n")
  else
    puts("Nachrichtenverlauf mit " + name);
    puts("-------------------------");

  print_conversation(chronMsgs);
  end;

when 6
...
~~~~

Wir bekommen folgenden Nachrichtenverlauf (bei einer Nachricht an und einer Nachricht an Frank):

    Nachrichtenverlauf mit Frank

    Frank schreibt:
    Hallo Sandra!

    Frank schreibt:
    Hallo zurück!


Ohje. Leider klappt das so noch nicht so ganz. Was geht schief? Das ist dahingehend etwas verwirrend, da ich die zweite Nachricht doch an Frank geschrieben habe und nicht er an mich.
Das Problem liegt an unserer Prozedur `print_conversation`. Diese geht davon aus, dass die entsprechenden Informationen im Nachrichtenarray enthalten sind: im ersten Eintrag der Name und im dritten Eintrag die Nachricht. Nun ist aber leider so, dass in beiden Nachrichtenarrays (gesendeten und empfangenen Nachrichten) jeweils Franks Name hinterlegt ist, da wir ja eben zwischen gesendeten und empfangenen Nachrichten unterscheiden müssen.

Wie können wir das Problem nun lösen? Ich schlage vor, dass wir unsere Sortierfunktion etwas spezieller auf unsere Anwendungswünsche ausrichten und die Information bzgl. empfangener und gesendeter Nachrichten explizit hinzufügen. Damit ändert sich unsere Funktion wie folgt:

~~~~{.ruby}
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
~~~~

Das bedeutet für unsere nachfolgenden Hilfsfunktionen, dass ein Nachrichtenarray nun wie folgt aussieht:

    [<rec | sent>, <Name>, <Timestamp>, <Message>]

Nun können wir `print_conversation` wie folgt definieren.

~~~~{.ruby}
def print_conversation(convArr,width)
  for i in 0..convArr.size-1 do
    if convArr[i][0] == "rec" then
      puts(convArr[i][1] + " schreibt:");
      puts(convArr[i][3]);
    else
      puts("Ich schreibe:")
      # Alternativ kann man sich eine globale Variable
      #  mit seinem Namen definieren oder zu Anfang einmal
      #  den Namen des Benutzers abfragen und im Folgenden
      #  verwenden
      # puts(userName + " schreibt:");
      puts(convArr[i][3].to_s);
    end;
  end;
end;
~~~~


Eine weitere Spielerei wäre einen der beiden Nachrichtentypen rechts einzurücken und sich die Namen ganz zu sparen. Ein paar Google-Suchen später kommt man dann auch mit der richtigen Hilfsfunktion von Ruby daher und definiert z.B. wie folgt (das `lineWidth`-Argument müsste im Aufruf entsprechend gesetzt werden (80 ist z.B. sehr beliebt für Konsolenausgaben).

~~~~{.ruby}
# All received messages are printed
#  with right alignment
#  (with respect to the given lineWidth),
#  the sent messages are printed normally (left)
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
~~~~
