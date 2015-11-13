# Language: Ruby, Level: Level 1

##
## Übungsbetrieb vom 5.11.2015
##
##  alle mit `#` beginnenden Zeilen sind Kommentare
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

# Berechnung der Summe von 0 .. n

# Variablen     n       sum         zaehler
#  -------------------------------------------------
#  1            3
#  2                     0
#  3                                   1
#  Bedingung: zaehler <= n (erfüllt)
#  4                     1
#  5                                   2
#  Bedingung: zaehler <= n (erfüllt)
#  4                     3
#  5                                   3
#  Bedingung: zaheler <= n (erfüllt)
#  4                     6
#  5                                   4
#  Bedinung: zaehler <= n (nicht erfüllt!)
#  6
#  7  Ausgabe: 6

#
## Präsenzaufgabe 2 - Primzahlen
#

# Aufzählen und Überprüfen
#   for-Schleife (Aufzählen -- wenn ich weiß, wie lange ich aufzählen soll)
#   while-Schleife (Aufzählen / Bedingung als Überprüfung)
#   if-then-else (Überprüfen)


# for i in 2 .. (x-1) do
#   rest = x % i;
#   puts(rest);
#   if rest == 0 then istPrimzahl = false; end;
# end;

# Eingabezahl > 1
x = 4;
istPrimzahl = true;
i = 2;
rest = 1;
# Abbruchbedinung:
#  i < x
# es reicht: x / 2
# es reicht tatsächlich sogar sqrt(x)
# sqrt(x) * sqrt(x) = x

# 36 = p * q (wobei p <= q)
# p > sqrt(x), wobei p der kleinere Teiler ist,
# dann ist p * sqrt(x) > x.
# Aber p sollte der kleinere Teiler sein => Widerspruch!
grenzwert = x / 2;

while rest != 0 && i < grenzwert do
  rest = x % i;
  i = i + 1;
  if rest == 0 then istPrimzahl = false;
  end;
end;

puts(istPrimzahl);

#
## Präsenzaufgabe 3 - Was macht das Programm?
#

x = 1.0;
while x != 0 do
  #puts(x);
  x = x / 2;
end;
puts(x);

#
## Einschub: Gleitkommazahlen?
#
# Vorzeichen  Mantisse  - Exponent
#    1 Bit     23 Bit      8 Bit       = 32 Bit
#    1 Bit                             = 64 Bit

# Ausgabe: keine -- terminiert nicht
# Ausgabe: 0.0 (wegen Rundung bei zu kleiner Zahlen)  - SIEGER!
# Ausgabe: Fehlermeldung, weil Speicher voll

puts(9999999999999999.0 - 9999999999999998.0);
# Ausgabe: 1.0
# Ausgabe: 0.0
# Ausgabe: 2.0   - SIEGER!
puts(9999999999999998.0 - 9999999999999993.0);
# Ausgabe: 6.0
puts(9999999999999999 - 9999999999999998);
# Ausgabe: 1

#
## Einschub: Binärdarstellung in Dezimaldarstellung
#
# Binärzahl: 101010
#
#   2^5      2^4        2^3            2^2       2^1         2^0
#    32        16        8               4         2           1
#
#    1         0         1               0         1           0
#
#   32          +        8               +         2
#
# Dezimalzahl: 42

#
## Einschub: Dezimaldarstellung in Binärdarstellung
#
# Dezimalzahl: 35
#
#  32 passt       1  -> 35 - 32 = 3
#  16 passt nicht 0
#   8             0
#   4             0
#   2 passt       1 ->  3 - 2 = 1
#   1 passt       1 ->  1 - 1 = 0
#
# Binärzahl: 100011