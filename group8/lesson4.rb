# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 26.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##
##   Diese Datei funktioniert nur auf `Level 4`,
##    da die Levels die Methodenschreibweise
##    nicht kennen.
##

# Wir kennen auch schon Funktionen, die in anderen
#  Modulen definiert sind.
# puts(Math.sin(1));

# Welches reverse darf in der Hausaufgabe benutzt werden?
# puts("test".reverse);

#
## Präsenzaufgabe 1
#

# puts("test".length);

n = -3 + 1 + 1;
# n1 = (-3 + 1) + 1;  tatsächliche Klammerung für n
n1 = -3.+(1).+(1);
# n2 = -3 + (1 + 1); aufgrund von Assoziativität auch möglich
n2 = -3.+(1.+(1));
puts(n == n1);
puts(n == n2);
k = 3 * n ** 2;
k1 = 3.*(n.**(2));  # einzig richtige Klammerung
# k2 = 3.*(n).**(2); # unsinnig
puts(k == k1);
puts(k == k2);
if k.>(0) then
  puts("ho".*(k));
end;


#
## Präsenzaufgabe 2
#

# Hier ist `abs` noch nicht sichtbar!
# z = abs(-3124);

def magic()
  return 42;
end;

def abs(x)
  if x < 0 then
    return -x;    #1
  else
    return x;     #2
  end;            #3
end;              #4
# Ab hier ist `abs` sichtbar!
x = abs(-3);      #5
y = abs(x);       #6
z = magic();
puts(x + y + z);      #7

# PP     x    y   abs(x)  Ausgabe
#---------------------------------
#  5                               # PP von abs     x    Ausgabe/Rückgabewert
#                                  #------------------------------------------
#                                  # Aufruf         -3
#                                  #  1                   Rückgabewert: -(-3)
# 5      3
# 6                                # PP von abs     x    Ausgabe/Rückgabewert
#                                  #------------------------------------------
#                                  # Aufruf         3
#                                  #  2                  Rückgabewert: 3
# 6          3
# 7                           6

## Methoden, Funktionen, Prozeduren

# Prozeduren
#  ... haben Seiteneffekte (z.B. Ausgabe auf dem Bildschirm)
#  ... können auch auf Argumente angewendet werden
# puts("test");

# Prints the given string with prefix "Ausgabe: "
def putsFancy(str)
  puts("Ausgabe: " + str);
end;
# putsFancy("test");

# Funktionen
#  ... haben eine `return`-Anweisung
#       und damit einen Rückgabewert!
# ... können auch auf Argumente angewendet werden
# z.B. abs, magic;

# Methoden (definiert für eine Klasse!)
# Bsp.
# Klasse: String, Methode: length()
# puts("test".length());
# Klasse: FixNum, Methode: +()
# puts(3.+(4));

# Test für valide Eingabe
# if eingabeZahl == 0 && eingabeString != "0" then puts(":(");
# else puts("okay");
# end;

def abfrage()
  print("Geben Sie eine Zahl ein: ");
  eingabeString = gets().chop();
  eingabeZahl = eingabeString.to_i();
  puts("eingabeZahl: " + eingabeZahl.to_s());
  puts("eingabeString: " + eingabeString);
  return eingabeString;
end;
# Anders als bei der for-Schleife, kennen wir
#  die Variablen innerhalb von abfrage()
#  nicht im Hauptprogramm!
# puts(eingabeString);

eingabe = abfrage();

# Nutzer soll solange eine Eingabe machen bis valider Wert eingegeben wurde
while eingabe.to_i() == 0 && eingabe != "0" do
  puts("Aktuelle Eingabe: " + eingabe);
  puts("Das war keine Zahl!");
  eingabe = abfrage();
end;
puts("Betrag: " + abs(eingabe.to_i()).to_s());


# abc   => nicht okay
# 134   => √
# -1235 => √
# 0     => √
# 124hdffh => :/

#
## Präsenzaufgabe 3
#

# n = 3
# X X X
#  XXX
# XXXXX
#  XXX
# X X X

# n = 4
# X  X  X
#  X X X
#   XXX
# XXXXXXX
#   XXX
#  X X X
# X  X  X

# Prints a star with height `2*n - 1`
def stern_zeichnen(n)
  if n >= 3 then
    # etwas sinnvolles passiert
    # puts("STERN!");

    # Vielleicht als String speichern und in der unteren
    #  Hälfte dann umkehren?
    # haelfte = "";
    # for zaehler in 1 .. n-1 do
    #   haelfte =  haelfte + "\n" + (" " * (zaehler-1) + (("X" + (" " * (n-zaehler - 1))) *3));
    # end;
    # Funktioniert wegen der Einrückung (von links) nicht!

    # obere Hälfte
    # puts(haelfte);
    for zaehler in 1 .. n-1 do
      puts((" " * (zaehler-1)) + (("X" + (" " * (n-zaehler - 1))) *3));
    end;

    # Mittelstück
    puts("X" * (2*n - 1));

    # untere Hälfte
    # puts(haelfte.reverse);
    for zaehler in 1 .. n-1 do
      puts((" " * (n- zaehler-1)) + (("X" + (" " * (zaehler - 1))) *3));
    end;
  end;
end;

# Hauptprogramm
puts("");
stern_zeichnen(1);
puts("");
stern_zeichnen(2);
puts("");
stern_zeichnen(3);
puts("");
stern_zeichnen(25);
