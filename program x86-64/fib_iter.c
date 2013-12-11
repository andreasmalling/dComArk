/* fib_iter.c */

#include <stdio.h>
#include <stdlib.h>

long long fib_iter(long long a)
{
  long long r = 0;
  long long minus_one = 1;
  long long minus_two = 0;
  long long i;

  if (a == 0) {
    r = 0;
  } else if (a == 1) {
    r = 1;
  } else {
    for (i = 2; i <i= a; i++) {
      r = minus_one + minus_two;
      minus_two = minus_one;
      minus_one = r;
    }
  }

  return r;
}

int main(int argc, char *argv[])
{
  long long a = 0;
  long long r = 0;

  a = atol(argv[1]);

  r = fib_iter(a);

  printf("fib(%qd) = %qd\n",a,r);
  return 0;
}
