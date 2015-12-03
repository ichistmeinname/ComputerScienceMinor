# Language: Ruby, Level: Level 1

##
## Übungsbetrieb vom 2.12.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##


#
## Präsenzaufgabe 1
#
# t = "bla", l = "l"
def count_occurrences(t, l)
  n = 0;
  if t == "" || l == "" then
    return n;
  else
    if t[0,1] == l then
      n = 1 + count_occurrences(t[1,t.length-1],l);
    else
      n = count_occurrences(t[1,t.length-1],l);
   end;
  end;
  puts(n);
  return n;
end;
########### "Hallo".length = 5; "Hallo".length - 1 = 4
#0 1 2 3 4
#H a l l o
#"Hallo"[1,4] => "allo"

# Hauptprogramm
puts("Text:");
text = gets().chop().downcase;
puts("Buchstabe: ");
#wir speichern nur den ersten Buchstaben
letter = gets()[0 ,1].downcase;
# puts(count_occurrences(text,letter));
n = count_occurrences(text,letter);
puts("Der Buchstabe '" + letter + "' kommt " + n.to_s() + " mal vor.");

#
## Präsenzaufgabe 2
#
def magic!(x, y)
  y = x + y;                 #1
  y[6, 1]= x[0, 1];          #2   y.[]=(6,1,x[0,1]) (y wird verändert!)
  x[2, 2]= y[x.length, 2];   #3
  y = y[2, 1];               #4
  x[0, 1]= y;                #5
  z = "";                    #6
end;                         #7
z = "komma";                 #8
magic!(z, z);                #9
puts(z);                     #10


# Bzgl. der Notation lohnt es sich auch
#  einen Blick in die Musterlösung zu werfen
#
# PP   z    Ausgabe
# 8   Obj1
#(9)                  PP       x             y                     z
#                     Aufruf  Obj1("komma") Obj1 ("komma")
#                     1                     Obj2 ("kommakomma")
#                     2                     Obj2 ("kommakkmma")
#                     3       Obj1("kokka")
#                     4                     Obj3 ("m")
#                     5       Obj1("mokka")
#                     6                                         Obj4("")
# 9
# 10          "mokka"
## Obj1 ###  ## Obj2 ###      ## Obj3 ### ## Obj4 ###
# String  #  # String  #      # String  # # String  #
# ------- #  # ------- #      # ------- # # ------- #
# "mokka" #  # "kommakkmma"#  # "m"     # # ""      #
###########  ###############  ########### ###########

# t = "Hallo";
# t[2,2] = "";
# puts(t);

#
## Präsenzaufgabe 3
#

## Zustände
# Spielwort (muss erraten werden) (word)
# die aktuellen Buchstaben / das bisher erratene Wort (progress)
##  (a,f,b)                       "aff_"
# Anzahl der bisherigen Rateversuche (tries)
# (vllt: Anzahl der maximalen Rateversuche)

## Methoden
# try_letter!(geratener_Buchstabe)
### (mutiert das bisher erratene Wort (progess))
# is_solved / is_game_over
# "getter"-Methoden für Zustände (get_word, get_progress,get_tries)
