Für den zweiten Teil müssen wir uns vorher überlegen

* wie wir die Nachricht auswählen lassen
* wie wir eine Nachricht aus dem Nachrichtenarray löschen

Es gab in den Übungen die Überlegung, alle Nachrichten zusammen auszugeben oder vorweg einmal nachzufragen, ob eine gesendete or empfangene Nachricht gelöscht werden soll. Wir werden uns beide Varianten einmal anschauen, fangen aber mit der (vermeindliche) einfachen Variante an, bei der wir nicht so viel nachfragen müssen.

Zur Anzeige der Nachricht müssen wir uns diesmal eigentlich nicht viel überlegen, schließlich stellt uns der Chat schon eine ganz praktische Funktionalität zur Verfügung.

~~~~{.ruby}
def pretty_print(mask, table, special_pos)
  for i in 0..table.size-1 do
    for j in 0..mask.size-1 do
      puts(mask[j] + ": " + (if j==special_pos then "\n" else "" end) + table[i][j]);
    end;
    puts("----------------------------");
  end;
end;
~~~~

Wir würden diese Funktion gerne wiederverwenden, müssen jedoch berücksichtigen, dass es sich hierbei um eine Prozedur handelt und wir eigentlich die Arrayausgabe für das Menü benutzen möchten. Kurz zur Erinnerung zeigen wir noch einmal das Menü.

~~~~{.ruby}
def menue(items)
  n = 0;
  while n<1 || n>items.size do
    for i in 0..items.size-1 do
      puts("(" + (i+1).to_s + ") " + items[i]);
    end;
    print("Deine Wahl: ");
    n = gets.to_i;
  end;
  return n;
end;
~~~~

Die `menu`-Prozedur erwartet ein Array von Strings und gibt in der Konsole diese Strings mit vorangestellter Nummerierung aus. Des Weiteren wird eine Nutzereingabe erwartet, die im Bereich der Nummerierung sein muss (sonst muss die Eingabe wiederholt werden), und gibt die ausgewählte Nummer des Menüs zurück.
Um `menu` zu benutzen, wäre es also hilfreich die `pretty_print`-Prozedur so zu verändern, dass nicht direkt auf die Konsole geschrieben wird, sondern ein Array aus Strings zusammengebaut wird, der nachher mittels `puts`/`print` ausgegeben werden kann und der bisherigen Ausgabe entspricht.

~~~~{.ruby}
def pretty_strings(mask, table, special_pos)
  pretty_strings = [];

  for i in 0..table.size-1 do
    string = "";
    for j in 0..mask.size-1 do
      # Instead of printed directly via `puts`, we concatenate the next line to the current `string`-value,
      #  since `puts` automatically adds a new line, we need to manually add `"\n"` at the end
      string = string + mask[j] + ": " + (if j==special_pos then "\n" else "" end) + table[i][j] + "\n";
    end;
    string = string + "----------------------------" +;

    # for each element in `table` we add a string-element to the array
    pretty_strings = pretty_strings + [string];
  end;

  return pretty_strings;
end;
~~~~

Wir können die alte Prozedur `pretty_print` dann wie folgt definieren:

~~~~{.ruby}
def pretty_print(mask, table, special_pos)
  puts(pretty_strings(mask,table,special_pos);
end;
~~~~~

Oder wir ändern die Vorkommen von `pretty_print` direkt und definieren gleich noch spezielle `pretty_strings`-Versionen für die zwei Typen von Nachrichten:

~~~~{.ruby}
# Yields an array of pretty strings for received messages
def pretty_strings_rec(recArr)
  return pretty_strings(["Von","Um","Das"],recArr,2);
end;

# Yiels an array of pretty strings for sent messages
def pretty_strings_sent(sentArr)
  return pretty_strings(["An","Um","Das"],sentArr,2);
end;

...
  when 1 # show received messages
    puts(pretty_strings_rec(received));
  when 2 # show sent messages
    puts(pretty_strings_sent(sent));
...
~~~~

Diese zwei weiteren Hilfsfunktionen kommen uns nämlich auch bei der eigentlichen Hauptaufgabe zu Gute. Dort wollen wir ja direkt empfangene und gesendete Nachrichten ausgeben, die aber im Menü richtig angezeigt werden sollen ("An"-/"Von"-Label).

Wie löschen wir jetzt eigentlich eine Nachricht aus dem Nachrichtenarray? Wir bekommen durch die `menu`-Funktion letztendlich eine Indexposition zurück, die wir verwendet können. SChreiben wir also kurz eine allgemein gültige Funktion, die ein Element an einer bestimmten Indexposition aus einem Array löscht.

Wenn wir die `idx`-the Position eines Array löschen wollen, können wir den Teil bis zu dem Element und den Teil vom Nachfolger bis zum Ende des Arrays konkatenieren -- dadurch "verlieren" wir das Elemente an der `idx`-ten Position automatisch.

~~~~{.ruby}
# Removes the element on `idx`th position in `arr`
def remove_at(arr,idx)
  return arr[0,idx] + arr[idx+1,arr.size-idx-1];
end;
~~~~

Jetzt können wir wieder alles zusammenfügen und die Abfragen drumrum implementieren.
Wir benötigen zum einen das entsprechende Arrays aus Nachrichtenstrings für das Menü und zum anderen ein Array mit den "reinen" Nachrichten, um die Auswahl nachher auch selektieren zu können.
Obwohl wir uns es eigentlich einfach machen wollten, wird es durch die gemeinsame Anzeige von beiden Nachrichtentypen nun etwas frickelig: die gewählte Nachricht entspricht nun ja einer Indexposition, die dem richtigen Array zugeordnet werden muss. Wir vergleichen diesen Index also mit der Arraysgröße des zuerst angezeigten Arrays (hier: gesendete Nachrichten); sollte der Index kleiner sein als die Größe dieses Arrays können wir das entsprechende Element direkt selektieren. Im anderen Fall wissen wir, dass sich das Element im anderen Array befindet und müssen den Offset (die größe des ersten Arrays) entsprechend vom Index abziehen, um die tatsächliche Indexposition im zweiten Arrray zu treffen.
Zu guter Letzt müssen wir jetzt nur noch die entsprechende Nachricht aus dem dazugehörigen Array löschen und das aktualisierte Array wieder als CSV-Datei abspeichern.

~~~~{.ruby}
...
  when 6
    puts("Welche Nachricht möchtest du löschen?");
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
      received = remove_at(received,msgChoice);
      csv_write(received_file,received);
    end;
 when 7
...
~~~~

Wie sieht nun die Variante mit einer zusätzlichen Abfrage und der Trennung von gesendeten und empfangenen Nachrichten aus? Dadurch dass wir `remove_at` als nicht-mutierende Funktion definiert haben, kommen wir nicht drumrum ein bisschen Code zu duplizieren. Bisher haben wir so programmiert, dass die Nachrichtenarrays (`received` und `sent`) jeweils mutieren und damit ausgenutzt, dass die Variablen immer den Wert abbilden. Der interessierte Leser kann sich ja an einer kürzeren Variante (ohne Code-Dulplikation) versuchen, in dem `remove_at!`, eine mutierende Variante, verwendet wird.

~~~~{.ruby}
...
  when 6
    puts("Möchtest du eine gesendete oder empfangene Nachricht löschen?");

    choice = menue(["Gesendete", "Empfangene"]);

    case choice
    when 1
      puts("Welche Nachricht möchtest du löschen?");

      msgChoice = menue(pretty_string_sent(sent)) - 1;

      sent = remove_at(sent,msgChoice);
      csv_write(file,msgs);
    when 2
      puts("Welche Nachricht möchtest du löschen?");

      msgChoice = menue(pretty_string_rec(rec)) - 1;

      rec = remove_at(rec,msgChoice);
      csv_write(file,msgs);
    end;
  when 7
...
~~~~
