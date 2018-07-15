int function(int a) {
  int i;
  i = 0;
  while (a > 1) {
    if (a & 1)
      a = 3 * a + 1;
    else
      a = a >> 1;
    i = i + 1;
  }
  return i;
}
