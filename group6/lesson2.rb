# Language: Ruby, Level: Level 1

##
## Übungsbetrieb vom 4.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1 - Programmsimulation
#

n = 10;                      #1
sum = 0;                     #2
zaehler = 1;                 #3
while zaehler <= n do
    sum = sum + zaehler;     #4
    zaehler = zaehler + 1;   #5
end;                         #6
puts(sum);                   #7

#
#      n     sum     zaehler     Ausgabe
#
# 1   3
# 2           0
# 3                    1
# Bedingung: zaehler <= n  (erfüllt)
# 4           1
# 5                    2
# Bedingung: zaehler <= n (erfüllt)
# 4           3
# 5                    3
# Bedinung: zaehler <= n (erfüllt)
# 4           6
# 5                    4
# Bedingung: zaehler <= n (nicht erfüllt)
# 6
# 7                                6

#
## Präsenzaufgabe 2 - Primzahltest
#

# Aufzählen und Überprüfen:
##  Schleife!
##  if-then-else/Schleifenbedinung

# Eingabezahl > 1
x = 2;
i = 2;  # durch 1 ist ja immer teilbar
rest = 0;
istPrimzahl = true;

# Abbruchbedinung überlegen!
# i echt kleiner als x
# grenzwert = x

# es reicht bis x / 2 zu prüfen
grenzwert = x / 2;

# es reicht tatsächlich bis sqrt(x) zu prüfen
# x = p * q (wobei p >= q)
# Wenn es eine Zahl q größer als sqrt(x) gäbe, die ein Teiler von x ist,
# und der kleinere der beiden Teiler wäre,
# dann wäre q also größer als sqrt(x) und q * sqrt(x) > x,
# aber dann ist q nicht der kleinere der beiden Teiler.
# Das ist ein Widerspruch.

while i < grenzwert && istPrimzahl do
  # wenn wir einen Teiler gefunden haben
  if x % i == 0
    then istPrimzahl = false;
    #   i = grenzwert;
    else i = i + 1;
  end;
end;

puts(istPrimzahl);

# counter = 0;
# for i in 1..x do
#   if x % i == 0
#     then counter = counter + 1;
#   end;
# end;
# if counter > 2
#   then istPrimzahl = false;
#  else istPrimzahl = true;
# end;
# puts(istPrimzahl);

#
## Präsenzaufgabe 3 - Was macht das Programm?
#

val = 1.0;
while val != 0 do
  # puts(val);
  val = val / 2;
end;
puts(val);
# Ausgabe: 0
# Ausgabe: unendlich
# Ausgabe: Fehlermeldung

# Was macht dieses Programm?
puts(9999999999999999.0 - 9999999999999998.0);
# Ausgabe: 2.0
puts(9999999999999998.0 - 9999999999999998.0);
#Ausgabe: 0.0
puts(9999999999999998.0 - 9999999999999997.0);
# Ausgabe: 2.0
puts(9999999999999999.0 - 9999999999999999.0);
# Ausgabe: 0.0
puts(9999999999999999 - 9999999999999998);
# Ausgabe: 1
puts(9999999999999997.0 - 9999999999999990.0);
# Ausgabe: 6.0

# Es kommt (vermutlich) zu einem Rundungsfehler
#  in der Binärdarstellung
