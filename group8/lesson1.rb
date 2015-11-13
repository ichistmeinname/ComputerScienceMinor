# Language: Ruby, Level: Level 1

##
## Übungsbetrieb vom 5.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

# Testwerte
x = false;
y = true;

# AND - Wahrheitstafel
# x y   x AND y
# T T     T
# T F     F
# F F     F
# F T     F
puts(if x then y else x end);

# OR - Wahrheitstafel
# x y   x OR y
# T T      T
# T F      T
# F F      F
# F T      T
puts(if x then x else y end);

# Betrag für Zahlenwerte
# wenn z positiv, dann soll z positiv bleiben
#               , sonst soll z positiv werden
z = (-12442);

# ist leider Quatsch:
#  beim Potenzieren wird die Zahl zwar auf jeden Fall positiv,
#  beim anschließenden Dividieren (bei negativem Z) wird
#  das Ergebnis allerdings wieder negativ
#puts(z**2/z);

# geht nur mit dem Mathe-Paket
#puts(Math.sqrt(z**2));

# für ganz pfiffige Studenten
#  geht es dann doch ohne Mathe-Paket
#puts((z**2)**0.5);

puts(if z >= 0 then z else z * (-1) end);

#
## Präsenzaufgabe 2
#

# Stack
#   zwei Operationen: push und pop
#   LIFO (last in, first out)
#
# Stackmaschine
#   wertet Ausdrücke aus
#   besteht aus Stack und Postfix-Ausdruck
#   Elemente des Stack sind Werte(!)
#   Vorbedingung: Ausdrücke müssen in Postfix-Notation vorliegen

# if_then_else(x != 0, y / x, 42)
# Baumstruktur
#
#         if_then_else
#       /     |     \
#     !=      (/)   42
#    /  \    /  \
#  x     0  y   x
#
# Aus Baumstruktur kann leicht Postfix-Notation abgeleitet werden
# Postfix-Notation
# x 0 != y x / 42 if_then_else

# Stackmaschine - go! für x = 5, y = 7
#  <Elemente des Stacks> | <Ausdruck in Postfix-Notation>
#  _ | 5 0 != 7 5 / 42 if_then_else
#  5 | 0 != 7 5 / 42 if_then_else
# 5 0 | != 7 5 / 42 if_then_else
# true | 7 5 / 42 if_then_else
# ..
# true 7 5 | / 42 if_then_else
# true `7 / 5` | 42 if_then_else
# true 1       | 42 _if_then_else
# true 1 42    | if_then_else
# 1            |     # Endkonfiguration

# Stackmaschine - go! für x = 0, y = 7
#  _ | 0 0 != 7 0 / 42 if_then_else
#  0 | 0 != 7 0 / 42 if_then_else
# 0 0 | != 7 0 / 42 if_then_else
# false | 7 0 / 42 if_then_else
# ..
# false 7 0 | / 42 if_then_else
## Hilfe: wir dürfen nicht durch 0 teilen!
# false `7 / 0` | 42 if_then_else
## mögliche Rettung der Stackmaschine durch Fehlerwert
# false ERR | 42 if_then_else
# false ERR 42 | if_then_else
# 42

## Aber in Ruby (und Spreadsheets) ist das alles kein Problem!
x1 = 0;
y1 = 7;
puts(if x1 != 0 then y1 / x1 else 42 end);

# Lernerfolg:
#  if_then_else verhält sich in Ruby, Spreadsheets (und anderen Programmiersprachen)
#   nicht-strikt im 2. und 3. Argument
