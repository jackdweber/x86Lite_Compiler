int function(int x) {
  if (x >= 1)
    return x * function(x - 1);
  else
    return 1;
}
