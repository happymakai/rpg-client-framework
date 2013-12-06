//

#ifndef  USE_SERVER_AS_CLIENT
#define server_client_list// to do something with the client
#define server // to manager the client list 
#else
#define client_client_single
#define server_client_list// to do something with the client
#define server // to manager the client list 
#endif

#define server_client_list.recieve function
#define server_config_file xml,sql

#define client_socket
#define server_socket



