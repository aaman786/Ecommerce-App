void main(List<String> args) {
  List l = [];

  List? list;

  for (var i = 0; i < 3; i++) {
    l.add(i);
    [i];
  }
  print(l);
  print(list);
}


 