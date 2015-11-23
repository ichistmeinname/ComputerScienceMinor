# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 5.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##


#
## Präsenzaufgabe 1
#

# Initialwert von 2000 Euro
# jährlich 500 Euro
# 0,15 % Zinsen
# Laufzeit: 5,10,15

laufzeit = 15;
kapital = 2000;
zinssatz = 0.0015;
bonus = gets().chop();
puts(bonus.length());
bonus = bonus.to_i();

# for jahr in 1 .. laufzeit do
#   kapital = kapital + bonus;
#   kapital = kapital + kapital * zinssatz;
#   if jahr % 5 == 0 then
#     puts("In Jahr " + jahr.to_s() + " sind " + kapital.to_s() + " Euro auf dem Sparbuch.");
#   end;
# end;
# puts(bonus);
jahr = 1;
while jahr <= laufzeit do
    kapital = kapital + bonus;
    kapital = kapital + kapital * zinssatz;
    if jahr % 5 == 0 then
      puts("In Jahr " + jahr.to_s() + " sind " + kapital.to_s() + " Euro auf dem Sparbuch.");
    end;
    jahr = jahr + 1;
end;

puts("Am Ende sind " + kapital.to_i().to_s() + " Euro auf dem Sparbuch.");


# geld = (2000 + 500 * laufzeit) * ((1 + zinssatz) ** laufzeit);
# puts(geld);


#
## Präsenzaufgabe 2
#

# EBNF:      Start ::= A (X | XX | Y) B
# BNF (V1):  Start ::= A X B | A XX B | A Y B
# BNF (V2):  Start ::= A Z B
#            Z     ::= X | XX | Y

# EBNF:      Start ::= A {X} B
# BNF:       Start ::= A Y B
#            Y     ::= X Y |

# EBNF:      Start ::= A ( X | XX | ) B C D [E] F G H [I] J K [L] M N

# ['a' ['b']]      ['a' ['b']]        ['a' ['b']]
#    |                /  \              /   \
#                   'a'  ['b']        'a'  ['b']
#                          |                 |
#                                           'b'
#                    'a'                'a''b'

# BNF (V1):  Start ::= A X B C D F G H J K M N | A B ...
# BNF (V2):  Start ::= A Y B C D Z F G H W J K V M N
#            Y     ::= X |
#            Z     ::= E |
#            W     ::= I |
#            V     ::= L |

# Satz     ::= Subjekt Prädikat [Adverb] [Adjektiv] Objekt '.'
# SatzAlt  ::= Subjekt Prädikat AdverbAdjektiv Objekt '.'
# AdverbAdjektiv ::= Adjektiv | Adverb | Adverb Adjekt |
# Adjektiv ::= 'rote' |
# Adverb   ::= 'nie' |
# Subjekt  ::= 'Frank' | 'Marie' | 'Der' 'Papst'
# Artikel  ::= 'Der' | 'Die' | 'Das' |   # PROBLEMATISCH! (falsche Ableitungen möglich)
# Prädikat ::= 'pflückt' | 'trägt'
# Objekt   ::= 'Blumen' | 'Kleider'


# Neue mögliche Ableitungen:
# Frank trägt nie Kleider.
# Marie pflückt rote Blumen.
# Der Papst trägt nie rote Kleider.


# Frank trägt Marie.

#                                Satz
#             /             |            |                    \
#       Subjekt          Prädikat       Objekt               '.'
#         |                 |             |
#        'Frank'           'trägt'
#
# Nicht ableitbar! Marie ist kein Objekt!
#
# Marie trägt Frank.
# Frank pflückt Marie.
# Marie pflückt Frank.
# Der Papst pflückt Frank.
# Der Papst pflückt Marie.
# Der Papst ...
# Kleider trägt Frank.
# Blumen pflückt Marie.
# ...


# Der Papst trägt Kleider.

#                                Satz
#             /             |            |                    \
#       Subjekt          Prädikat       Objekt               '.'
#        /  \                 |             |
#    'Der' 'Papst'         'trägt'       'Kleider'


# Marie pflückt Blumen.

#                                Satz
#             /             |            |                    \
#       Subjekt          Prädikat       Objekt               '.'
#         |                 |             |
#       'Marie'          'pflückt'      'Blumen'



#
## Präsenzaufgabe 2
#


#
## Präsenzaufgabe 3
#
