# Language: Ruby, Level: Level 4
graph = [[1,2,3], [3,6], [5], [5,6], [1,3], [], [4,5]]


# Vorgehen:
# Solange der `target`-Knoten noch nicht erreicht wurde,
#  suche ich ausgehend von den Nachfolgern des `start`-Knotens
#  nach einem Pfad zum `target`-Knoten.
# Um Kreisläufe (Zykel!) zu vermeiden, lösche ich für die
#  rekursiven Aufrufe den gerade besuchten (`start-`)Knoten
#  aus dem Graphen.
def is_reachable(graph,start,target)
  # Ist mein `start`-Knoten schon mein `target`-Knoten?
  reachable = start == target;

  # Was sind die Nachfolger vom `start`-Knoten?
  start_succ = graph[start];

  index = 0;

  # Klone den Graphen, um den gerade besuchten
  #  `start`-Knoten zu löschen ohne den Graph zu mutieren.
  g = graph.clone;
  g[start] = [];

  # Suche rekursiv für alle Nachfolger nach einem Pfad
  #  zum `target`-Knoten im Graph ohne den `start`-Knoten.
  # Breche  die `while`-Schleife ab, sobald eine Lösung gefunden
  #  wurde.
  # Anmerkung: Im Fall der Übereinstimmung von `start` und `target`
  #  wird die `while`-Schleife gar nicht erst betreten.
  while !reachable && index < start_succ.size do
    reachable = is_reachable(g,start_succ[index],target);
    index = index + 1;
  end;

  # Gebe booleschen Wert zurück, der angibt, ob der
  #  `target`-Knoten vom `start`-Knoten erreichbar ist.
  return reachable;
end;


puts(is_reachable(graph, 0, 4)) # -> true
puts(is_reachable(graph, 2, 3)) # -> false
