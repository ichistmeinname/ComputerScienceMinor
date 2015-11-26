# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 5.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##
##   ACHTUNG: Diese Datei läuft aufgrund der
##           Methodenschreibweise nur auf Level 4.
##

# Prozedur hat "nur" Seiteneffekte (z.B. Bildschirmausgabe)
def magic(x)
  puts(x * x);
end;

# Funktion hat einen Rückgabewerte
def magic2(z)
  return (z * z);
end;

# Methoden sind immer auf einem Objekt definiert
#  Wie das aussieht, sehen wir später (Januar?)


#
## Präsenzaufgabe 1
#

# Methodenaufruf auf String ohne Argumente
puts("34235".length());

n = -3 + 1 + 1;
# Möglichkeit #1
n1 = -3.+(1).+(1);
# nExtra1 = -3.+(1);
# n1a = nExtra1.+(1);
# puts(n == n1);
# puts(n == n1a);
# Möglichkeit #2
n2 = -3.+(1.+(1));
# nExtra2 = 1.+(1);
# n2a = -3.+(nExtra2);
# puts(n == n2);
# puts(n == n2a);
k = 3 * n ** 2;
# Nur eine Möglichkeit der Klammerung, da Präzedenzen klar geregelt sind!
k1 = 3.*(n.**(2));
# puts(k == k1);
# Wir können natürlich Kommutativität von `*` ausnutzen
k11 = n.**(2).*(3);
# puts(k == k11);

if k.>(0) then
  puts("ho".*(k));
end;

#
## Präsenzaufgabe 2
#

# Hier ist `abs` noch nicht definiert!
# z = abs(5);

#          |
# Dieses   v  x ist nur innerhalb der Funktionsdefinition von `abs` sichtbar
def    abs(x)
  if x < 0 then
    return -x;    #1
  else
    return x;     #2
  end;            #3
end;              #4
# Ab hier schon!

# Das andere x ist global (ab hier) sichtbar!
x = abs(-3);      #5
y = abs(x);       #6
puts(x + y);      #7

# PP    x      y    Ausgabe
#----------------------------
# 5                            # PP von abs    x   Rückgabewert/Ausgabe
#                              #----------------------------------------
#                              # Aufruf        -3
#                              #  1                 Rückgabewert: -(-3)
# 5     3
# 6                            # PP von abs    x   Rückgabewert/Ausgabe
#                              #----------------------------------------
#                              # Aufruf        3
#                              #  2                Rückgabewert: 3
# 6            3
# 7                   6

# Neues Hauptprogramm für `abs`

# gewünschtes Verhalten
# 5  => √
# abfgdyt => : (
# 0  => √
# -13245 => √
# 2342hgfgf34 => : /
# puts(eingabe.to_i());

# Prüfe auf sinnvollen Wert
# if eingabe.to_i() != 0 || eingabe == "0"
#   then puts("√");
# else puts(": (");
# end;

# Solange prüfen bis die Eingabe sinnvoll ist
print("Geben Sie eine Zahl ein: ");
eingabe = gets().chop();

#            negiert
# a || b   ---------> !a && !b

while (eingabe.to_i() == 0 && eingabe != "0") || eingabe.to_i().to_s() != eingabe do
  print("Das ist keine Zahl, versuche es noch einmal: ");
  eingabe = gets().chop();
end;

puts(abs(eingabe.to_i()))

#
## Präsenzaufgabe 3
#
#  n = 3
# X X X
#  XXX
# XXXXX   (2n-1)
#  XXX
# X X X

# n = 4
# X  X  X
#  X X X
#   XXX
# XXXXXXX (2n-1)
#   XXX
#  X X X
# X  X  X

# Draws a star with height `2*n-1`
def stern_zeichnen(n)
  if n > 2 then

  # obere Hälfte
  for z in 1 .. n-1 do
    puts( " " * (z - 1) + (("X" + " ".*(n - 1 - z)) * 3));
  end;
  # Mittelstück
  puts("X" * (2*n-1));

  # untere Hälfte
  for z in 1 .. n-1 do
    puts( " " * (n - 1 - z) + (("X" + " ".*(z - 1)) * 3));
  end;

  end;
end;

# Hauptprogramm
stern_zeichnen(1);
puts("");
stern_zeichnen(2);
puts("");
stern_zeichnen(3);
puts("");
stern_zeichnen(60);
puts("");
