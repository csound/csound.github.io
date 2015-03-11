#include <stdlib.h>
#include <stdio.h>

void doSomething(int vals[]) {
  printf("vals: %d\n", vals[1]);
}

int main(int argc, char** argv) {
  int vals[2][2] = {{1,2}, {3,4}};
  printf("vals: %d\n", vals[1][1]);
  doSomething(vals[1]);
  int *vals2 = vals[0]; // <- this causes a compiler error
}
