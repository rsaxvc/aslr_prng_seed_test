#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>

int main( void )
{
printf("%p %p %" PRIxPTR" %" PRIiPTR "\n",malloc, printf, (uintptr_t)malloc^(uintptr_t)printf, (intptr_t)((uintptr_t)malloc - (uintptr_t)printf));
return 0;
}
