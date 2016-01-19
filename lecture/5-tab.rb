# Language: Ruby, Level: Level 4
# write a two-dimensional array (a tabular)
# as csv-value to file filename
def csv_write(filename,a)
  csv_str = "";
  for i in 0..a.size-1 do
    for j in 0..a[i].size-2 do
      csv_str = csv_str + a[i][j].to_s + ","
    end;
    csv_str = csv_str + a[i][j+1].to_s + "\n";
  end;
  File.write(filename,csv_str);
end;

# read csv-file from filename and return its value
# as a two-dimensional array
def csv_read(filename)
  str = File.read(filename);
  a = str.split("\n");
  for i in 0..a.size-1 do
    a[i] = a[i].split(",");
  end
  return a;
end;

personen = [["Frank" ,188,true ],
            ["Sandra",162,false],
            ["Sandro",168,false],
            ["Willi" ,198,true ]];

csv_write("personen.csv",  [["Name","Groesse","Anwesenheit"]]+personen);
p(csv_read("stundenplan2.csv"));
