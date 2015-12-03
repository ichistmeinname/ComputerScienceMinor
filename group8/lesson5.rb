# Language: Ruby, Level: Level 1

##
## Übungsbetrieb vom 3.12.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##


#
## Präsenzaufgabe 1
#

# Prozedur
# hat "nur" Seiteneffekte (z.B. puts(...) -- Ausgabe)

# Funktion
# hat immer einen Rückgabewert

def count_occurrences(t, l)
  n=0;
  for i in 0 .. t.length()-1 do
    if t[i,1] == l then n = n+1;
    end;
  end;
  return n;
end;

# Schmeißt den ersten Buchstaben des übergebenen Strings weg
#  und gibt den Rest zurück!
def tail(str)
  # return str.reverse.chop.reverse;
  # H a l l o
  # 0 1 2 3 4
  # return "Hallo"[1,5-1];
  return str[1,str.length-1];
  # return str.[](1,str.length-1)
end;
#
# puts(tail("Hallo"));

def count_occurrences_rec(t, l)
  n = 0;
  if t != ""  then # "" ist der leere String
    if t[0,1] == l then # prüfe die erste Stelle des Strings
      # Hier habe ich den Buchstaben gefunden
      n = 1 + count_occurrences_rec(tail(t),l);
      # return 1 + count_occurrences_rec(tail(t),l);
    else
      # Hier habe ich den Buchstaben nicht gefunden
      n = count_occurrences_rec(tail(t),l);
      # return count_occurrences_rec(tail(t),l);
    end;
  end;
  puts(n);
  return n;
end;
# puts("Ausgabe: " + count_occurrences_rec("abb","b").to_s);
#
# # 1 + 1 + 0  =>  2

def my_counter_function()
  puts("Text:");
  text = gets().chop().downcase; # "Hallo"
  puts ("Buchstabe:") ;
  letter = gets()[0 ,1].downcase; #wir speichern nur den ersten Buchstaben
  count = count_occurrences(text,letter);
  puts("Der Buchstabe '" + letter + "' kommt " + count.to_s() + " mal vor.");
end;

# Hauptprogramm
# my_counter_function();

# Wiederholung zur Teilstringselektierung
# str = "Hallo Welt";
# # 0 1 2 3 4 5 6 7 8 9
# # H a l l o   W e l t
# puts(str[5,4]); # " Wel"
# puts("Hallo"[5,1] == "");
# puts("Hallo"[1246,1] == nil);
# H a l l o
# 0 1 2 3 4

#
## Präsenzaufgabe 2
#

def magic!(x, y)
  y = x + y;                 #1
  y[6, 1] = x[0, 1];         #2 # y.[]=(6,1,x[0,1])
  x[2, 2] = y[x.length, 2];  #3 # x.[]=(2,2,y[x.length,2])
  y = y[2, 1];               #4
  x[0, 1] = y;               #5 # x.[]=(0,1,y)
  z = "";                    #6
end;                         #7

z = "komma";                 #8
magic!(z, z);                #9
puts(z);                     #10

# PP   z             Ausgabe
# 8   Obj1 ("komma")
# (9)                          # PP           x                       y                      z
#                              # Aufruf     Obj1("komma")         Obj1("komma")
#                              # 1                                Obj2("kommakomma")
#                              # 2                                [Obj2("kommakkmma")]
#                              # 3          [Obj1("kokka")]
#                              # 4                                Obj3
#                              # 5          [Obj1("mokka")]
#                              # 6                                                             Obj4
# 9
# 10                  "mokka"

########## ##############  ########## ##########
## Obj1 ## ## Obj2     ##  ## Obj3 ## ## Obj4 ##
# STRING # # STRING     #  # STRING # # STRING #
#--------# #------------#  #--------# #--------#
# "mokka"# #"kommakkmma"#  # "m"    # # ""     #
########## ##############  ########## ##########

# Wiederholung: Teilstringersetzung
# test = "Hallo";
# puts(test[2,2]);
# test[2,2] = "abc";
# puts(test);

#
## Präsenzaufgabe 3
#
