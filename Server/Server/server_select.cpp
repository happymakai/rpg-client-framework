#include "../lib/lib.h"

//////////////////////////////////////////////////////////////////////////
//Net Defination
//////////////////////////////////////////////////////////////////////////
//SOCKET server_socket=INVALID_SOCKET ;

SOCKADDR_IN server_addr ;
SOCKADDR_IN client_addr ;
SOCKET client_socket=INVALID_SOCKET;
int err=0;
int server_port =9999;
int addrlen=sizeof(SOCKADDR_IN);
char recv_buf[1024]={0};
char send_buf[1024]={0};
bool sayhi =true;
//////////////////////////////////////////////////////////////////////////