# Language: Ruby, Level: Level 1

##
## Übungsbetrieb vom 18.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#Var   ::= ('a' | 'b') ['_' Digit {Digit}]
# Mögliche Werte:
# a_90032
# a
# b_32457
# b_3


#
## Präsenzaufgabe 1
#
# 2000 Euro initial
# 500 Euro jährlich als Bonus
# 0,15 % Zinsen jährlich
# nach 5, 10 bzw. 15 Jahren

kapital = 2000;
zinsen = 0.0015;
bonus = 500;
laufzeit = 15;
for jahr in 1 .. laufzeit do
  puts(kapital);
  kapital = kapital + bonus;
  kapital = kapital + kapital * zinsen;
end;
# jahr = 1;
# while jahr <= laufzeit do
#     puts(kapital);
#     kapital = kapital + bonus;
#     kapital = kapital + kapital * zinsen;
#     jahr = jahr + 1;
# end;
# wunschAlsString = gets().chop();
# puts(wunschAlsString.length());
# puts(wunschAlsString);
# wunsch = wunschAlsString.to_i();
# puts(wunsch.to_s() + '!');
# print(wunsch.to_s() + " Euro\n");
# zeitInJahren = 0;
# while kapital < wunsch do
#   if zeitInJahren <= 15
#     then kapital = kapital + bonus;
#   end;
#   kapital = kapital + kapital * zinsen;
#   zeitInJahren = zeitInJahren + 1;
# end;
# puts("Es dauert leider " + zeitInJahren.to_s() + " Jahre.");
puts(kapital);

#
## Präsenzaufgabe 2
#

# Satz ::= Subjekt Prädikat Beide Objekt '.'
# Beide ::= Kat1 | Kat2 | Kat1 Kat2 |
# Kat1 (alias Adverb) ::= 'nie'
# Kat2 (alias Adjektiv) ::= 'rote'
# Subjekt ::= 'Frank' | 'Marie' | 'Der' 'Papst'
# Prädikat ::= 'pflückt' | 'trägt'
# Objekt ::= 'Blumen' | 'Kleider'

# EBNF:     Start ::= A B [ X ] C D [ E ] F [ G ] H I J
# BNF (V1): Start ::= A B Y C
#           Y ::= X |
# BNF (V2): Start ::= A B X C | A B C

# Start ::= A [B]   -> A'x'
# B ::= 'x'

# EBNF:     Start ::= A { B }  -> A
#           B ::= 'x'
# BNF (V1): Start ::= A | A B
#           B ::= 'x' | 'x' B

# EBNF:     Start ::= A (B | C) D
# BNF (V1): Start ::= A B D | A C D

# Satz in ganz kompakt:
# SatzKompakt ::= Subjekt Prädikat [Beide'] Objekt '.'
# Beide' ::= Kat1 | Kat2 | Kat1 Kat2
# SatzSKompakt ::= Subjekt Prädikat ['nie'] ['rote'] Objekt '.'

# Neue mögliche Sätze:
# Frank trägt nie Kleider.
# Marie pflückt rote Blumen.
# Der Papst trägt nie rote Kleider.

# Frank trägt Marie.
#
#                     Satz
#        /            |             |          \
#    Subjekt       Prädikat      Objekt       '.'
#     |               |            |
#    Frank           trägt       ERROR! -- Marie ist kein Objekt!
#
#
# Marie pflückt Kleider.

# Der Papst trägt Kleider.
#
#                     Satz
#        /            |             |          \
#    Subjekt       Prädikat      Objekt       '.'
#     /  \            |            |
#  'Der' 'Papst'    'trägt'       'Kleider'
#
#

# Marie pflückt Blumen.
#
#                     Satz
#        /       |             |          \
#    Subjekt   Prädikat     Objekt       '.'
#       |         |           |
#    'Marie'    'pflückt'    'Blumen'
#

#
## Präsenzaufgabe 3
#
#
# Val ::= Num | '-' Num | true | false
# Num ::= Dig | Dig Num
# Dig ::= '0' | ... | '9'

# Exp :: = Var
#        | Val
#        | '(' Exp Op Exp ')'
#        | Fun '(' Exps ')'
#        | 'if' Exp 'then' Exp 'else' Exp 'end'
# Exps ::= Exp
#        | Exp ',' Exps
# Op ::= '+' | '-' | '*' | '/' | '**'
# Fun ::= 'Math.sqrt' | 'Math.sin' | ...
# Var ::= 'x' | 'y' | 'z' | ...

# Ableitung: (Math.sin(x+1)*(x-1))
# => nicht möglich!

#                    Exp
#
#      '('   Exp       Op      Exp    ')'
#            /         |        \
#   Fun  '('  Exps ')'   *    '(' Exp Op Exp ')'
#    |         |
#  Math.sin   Exp                 Var - Val (s.l)
#         /  / |   \  \
#      '(' Exp Op Exp ')'
#
#           Var + Val
#           'x'   Num
#                 Dig
#                  1

# => '(' Math.sin  '(' '(' 'x' + 1 ')' ')' * '(' 'x' - 1 ')' ')'
