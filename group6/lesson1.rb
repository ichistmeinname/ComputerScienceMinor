# Language: Ruby, Level: Level 1

##
## Übungsbetrieb vom 4.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

x = true;
y = false;

# OR
puts(if x then x else y end);

# AND
puts(if x then y else x end);

z = -1131;

# Betrag von Zahlenwerten
puts(if z > 0 then z else z * (-1) end);

# Baumstruktur von `Betrag`
#            puts
#             |
#          if_then_else
#         /     |       \
#       Bed.  then-Zw.  else-Zw.
#        >      z         *
#       /  \            /   \
#      z   0           z    (-1)

# Postfix-Notation von `Betrag`
# z 0 > z z (-1) * if_then_else puts

# Stackmaschine
#   zwei Operationen: push, pop
#   LIFO-Prinzip: last in, first out

#   Aufbau der Stackmaschine
#     <STACK> | <Ausdruck in Postfix-Notation>
#     Wichtig: Elemente des Stacks müssen Werte sein
#     Wichtig: bei der Anfangskonfiguration ist der Stack leer
#     Wichtig: bei der Endkonfiguration ist der Ausdruck komplett
#              abgearbeitet und auf dem Stack liegt nur noch ein(!) Wert
#

#
## Präsenzaufgabe 2
#

#   Ausführung der Stackmaschine
#    für `if z > 0 then z else z * (-1) end`
#    mit z = 42
#  | 42 0 > 42 42 (-1) * if_then_else # Anfangskonfiguration
# 42 | 0 > 42 42 (-1) * if_then_else
# 42 0 | > 42 42 (-1) * if_then_else
# true | 42 42 (-1) * if_then_else
# ...
# true 42 42 (-1) | * if_then_else
# true 42 (-42) | if_then_else
# 42 |   # Endkonfiguration
#

#   Ausführung der Stackmaschine
#    für `if_then_else(x != 0, y / x, 42)`
#    mit x = 0 und y = 5
#  | x 0 != 5 0 / 42 if_then_else
# ...
# x 0 | != 5 0 / 42 if_then_else
# false | 5 0 / 42 if_then_else
# ...
# false 5 0 | / 42 if_then_else
## Problem: wir dürfen nicht durch 0 teilen!
# false <Wert von `5 / 0`> | 42 if_then_else

# In Ruby (und Spreadsheet) ist das alles aber gar kein Problem
x1 = 0;
y1 = 7;
puts(if x1 != 0 then y1 / x1 else 42 end);

# Lernerfolg:
#  In Sprachen wie Ruby ist der if_then_else-Ausdruck nicht-strikt
#   im zweiten und dritten Argument!