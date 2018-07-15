#include<stdlib.h>
#include<stdio.h>

extern long long int function();

int main(int argc, char **argv) {
  long long int ret = function();
  printf("program returned: %llu\n", ret);
  return 0;
}
