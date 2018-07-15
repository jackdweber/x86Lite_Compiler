#include<stdlib.h>
#include<stdio.h>

extern long long int function(long long int argument);

int main(int argc, char **argv) {
  long long int arg = atoi(argv[1]);
  long long int ret = function(arg);
  printf("program given %llu, returned: %llu\n", arg, ret);
  return 0;
}
