int function(int x) {
  int i;
  i = 0;
  while (x >= 0) {
    x = x - 1;
    if (x & 7) continue;
    i = i + 1;
  }
  return i;
}
