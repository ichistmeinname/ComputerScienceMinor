Nachdem wir das Grundgerüst durch die verschiedenen Aufgabenteile durch sinnvolle Funktionalitäten erweitert haben, lohnt sich ein erneuter Blick auf das Weiterleiten von Nachrichten aus der Präsenzaufgabe. Bisher haben wir das Auswahlmenü eher rudimentär umgesetzt (in der Übung ist ja meist auch eher begrenzt Zeit). Eine ähnliches Menü haben wir uns bereits angeschaut, als wir das Löschen einer Nachricht implementiert haben. Dadurch dass wir keine Änderungen an den Arrays abhängig vom Auswahlindex treffen (zuvor musste eine Nachricht gelöscht werden), sondern in jedem Fall eine Nachricht der im Array der gesendeten Nachrichten hinzufügen müssen, können wir uns hier ein paar Abfragen sparen.

~~~~{.ruby}
...
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
    # prefix "FWD:"
    message = "FWD:\n" + all[msgChoice-1][2];

    puts("An wen moechten Sie die Nachricht weiterleiten?");
    # receiver's name
    name = gets.chop;

    # Add to sent messages and save table to file
    sent = sent + [ [name, Time.now.to_s, message] ];
    csv_write(sent_file, sent);
  end;
...
~~~~

Als weitere Verschönerung können wir die Weiterleitungsnachricht etwas aufwendiger gestalten. Normalerweise steht in einer Weiterleitung ja von wem die Originalnachricht geschrieben und wann sie verschickt bzw. erhalten wurde. Diese Informationen stehen uns auch zur Verfügung -- zumindest fast. Wenn wir eine von uns gesendete Nachricht weiterleiten, steht in dieser Nachricht der Empfängername und nicht unser Name. Da können wir wiederum damit behelfen, dass wir global einmal den Namen festhalten (z.B. durch eine Anfrage am Anfang).

~~~~{.ruby}
...
sent = csv_read(sent_file)
received = csv_read(received_file)

# Store the user's name globally at the beginning of a session
print("Wie ist dein Name? ");
userName = gets.chop;
...
...
  when 7
    ...

    # Set message's text to chosen text with an additonal
    #  "FWD: "-prefix
    message = "FWD Nachricht von ";

    # Concatenate name of original sender
    if msgChoice < sent.size then
      message = message + userName
    else
      message = message + msgs[msgChoice][0];
    end;

    # Add time-stamp in message...
    message = message + " um " + msgs[msgChoice][1];
    # ...as well as the original text
    message = message + "\n>>" + msgs[msgChoice][2] + "<<";

    ...
  end;
...
~~~~

Zu guter Letzt können wir feststellen, dass wir zum Weiterleiten der Nachricht den gleichen Code verwendet wie für das reine Verschicken einer Nachricht (was ja auch sinnig ist). Bei doppelter Verwendung liegt es nahe, diese Funktionalität auszulagern. Wir müssen ledigleich aufpassen, die bisherige Annahme, dass die Nachrichtenarrays `sent` und `receive` auf den aktuellen Stand gehalten werden, nicht gebrochen wird. Es bietet sich an, eine Funktion zu schreiben, die das veränderte Array nach dem Verschicken einer Nachricht zurückgibt. Als Argumente benötigen wir alle Informationen zum Verschicken einer Nachricht: den Empfänger, die Nachricht. Des Weiteren müssen wir wissen in welche Datei das aktualsierte Array geschrieben werden muss und natürlich das eigentliche Nachrichtenarray. Den Zeitstempel können wir in der Funktion selbst "berechnen" (wir nehmen dann wie immer die aktuelle Zeit).

~~~~{.ruby}
def send_message(file,arr,name,msg)
  arr = arr + [[name,Time.now.to_s,msg]];
  csv_write(file,arr);
  return arr;
end;
~~~~

Dabei fällt uns natürlich auf, dass die gleiche Argumentation der Wiederverwendung auch für das eigentliche Eintippen der Nachricht (beim Senden und Empfangen) gilt.

~~~~{.ruby}
def getsMessage()
  input = "";
  text = gets;
  while text!="\n" do
    input = input + text;
    text = gets;
  end;
  # Get rid of last `\n`
  return input.chop;
end;

~~~~

Jetzt müssen wir die bisherigen Verwendungen dieser Funktionalitäten nur noch durch Verwendung von `send_message` und `gets_message` anpassen.

~~~~{.ruby}
...
  when 3 # send a message
    print("An wen willst du eine Nachricht schicken? ");
    name = gets.chop;
    puts("Was willst du " + name + " schreiben? ");
    input = getsMessage;
    sent = send_message(sent_file,sent,name,input);

  when 4
    print("Wer hat dir geschrieben? ")
    name = gets.chop
    puts("Was hat " + name + " geschrieben? ")
    input = gets_message;
    received = received + [[name,Time.now.to_s,input]]
    csv_write(received_file,received)

  ...

  when 7

    ...
    puts("An wen möchtest du die Nachricht weiterleiten?");
    # receiver's name
    name = gets.chop;

    sent = send_message(sent_file,sent,name,message);

  end;
...
~~~~
