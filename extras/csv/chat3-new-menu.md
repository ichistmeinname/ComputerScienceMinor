Um diese Aufgabe zu realisieren, ändern wir die Anzeige für ersten beiden Menüpunkte. Wir wollen eine Prozdur mit ähnlicher Funktionalität wie dem Original `pretty_print` realisieren, die die Nachrichten nur in 5er-Blöcken anzeigt.

~~~~{.ruby}
...
  when 1 # show received messages
    print_messages(received,["Von","Um","Das"],5);
  when 2 # show sent messages
    print_messages(sent,["An","Um","Das"],5);
...
~~~~

Wie kann `print_messages` nun aussehen? Wir übergeben drei Argumente: das Array, die Labels und die Blockgröße. Aus dem übergebenen Array können wir dann schon mit Hilfe von `pretty_strings` aus Teil (a) ein Array der Anzeigestrings generieren. Nun müssen wir in einer Schleife dem Benutzer ermöglichen, weitere Nachrichten anzuzeigen. Es ist aber vorher nicht klar, wie oft wir den Rumpf ausgeführt werden, daher wählen wir eine `while`-Schleife. Insbesondere kann es sein, dass die Anzahl der Nachrichten die Blockgröße gar nicht überschreitet, so dass wir kein weiteres Menü anzeigen müssen, sondern direkt fertig sind mit der interaktiven Anzeige.

~~~~{.ruby}
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
    if strArr.size >= boundEnd then

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
~~~~
