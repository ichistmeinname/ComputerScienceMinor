# Language: Ruby, Level: Level 4

# Beispeil für Programmsimulation

# PP   a  b         #
# ----------------- #
# 3   10            #   PP für bla            y   x    Rückgabewert
# 4                 #   ---------------------------------------------
#                   #    Aufruf mit y = 10   10
#                   #   #1                        42
#                       #2                               42
# 4      42
#
def bla(y)
  x = 42;         # 1
  return x;       # 2
end;

a = 10;            # 3
b = bla(a);        # 4

# p(b);

# while-Schleifen und for-Schleifen sind in Ruby
#  Ausdrücke, die auch einen Rückgabewert haben!

p(for j in 0..5 do puts(j+10) end);
p(for j in for i in 0..5 do puts(i) end do puts(j+10) end);

i = 0;
p(while i < 3 do
  puts(i);
  i = i + 1;
end);

a = "Hallo Welt!";
c = "l";
b = false;
i = 0;

# Teste, ob c in a vorkommt
while !b && i < a.length-1 do
  b = a[i] == c;
  i = i + 1;
end;



edges = [[0,1],[0,3],[0,4],[1,2],[1,3],[1,4],[2,3],[3,4]]

# delete([1, 2, 3, 4],2)
#              ---
#        [1,2]  + [4]
def delete(arr,index)
  # res = arr.clone;
  res = arr[0,index] + arr[index+1,arr.size-(index+1)];
  return res;
end;

def delete_alt(arr,index)
  new_arr = arr.clone;
  # new_arr.[]=(index,1,[]) !!! Methodenaufruf !!!
  new_arr[index,1] = [];
  # 4 = 12 !!! geht ja auch nicht, links von einer
  #   Zuweisung muss eine Variable stehen!
  return new_arr;
end;

# p(delete([1,2,3,4],2));
# p(delete_alt([1,2,3,4],2));

def possible_succs(vertex,edges)
  p_succs = [];

  for i in 0..edges.size-1 do
    if edges[i][0] == vertex then
      succ = edges[i][1];
      new_edges = delete(edges,i);
      p_succs = p_succs + [[succ,new_edges]];
    elsif  edges[i][1] == vertex then
      succ = edges[i][0];
      new_edges = delete(edges,i);
      p_succs = p_succs + [[succ,new_edges]];
    end;
  end;

  return p_succs;
end;

def find_solution(path,edges)
  solutions = [];

  if edges == [] then
    # [1,2,3] + 3
    # [1,2,3] + [3]
    # [[1,2],[3,4]] + [3] = [[1,2],[3,4],[3]]

    solutions = solutions + [path];
  else

    start = path[path.size-1];
    p_succs = possible_succs(start,edges);

    for i in 0..p_succs.size-1 do
      # p_succs.[](i) ~> p_succs[i];
      new_start = p_succs[i][0];
      new_edges = p_succs[i][1];
      solutions = solutions + find_solution(path + [new_start],new_edges);
    end;
  end;

  return solutions;
end;

# p(possible_succs(2,edges));
# p(find_solution([0],edges).size)
# p(find_solution([4],edges).size)
for i in 0..4 do
  p(find_solution([i],edges).size);
end


# kann b[1]["hallo"] 42 ergeben?
b = [0,{"hallo" => 42}] ;
p(b[1]["hallo"]);
a = 1;
b = 4;

# Methodenschreibweise
p(a+b**2*3);
p(a.+(b.**(2).*(3)));

# Methodenschreibweise
c = [1,2,3,4,5];
p(c[2, 2] = [Math.sqrt(b + c[4])]);

c = [1,2,3,4,5];
p(c.[]=(2, 2, [Math.sqrt(b.+(c.[](4)))]));
