#include <stdio.h>
#include <unistd.h>

void zing(){
    char *user;
    user = getlogin(); 
    printf("Hello again, %s\n", user); 
}
