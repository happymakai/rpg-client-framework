#include "../lib/lib.h"
 
//////////////////////////////////////////////////////////////////////////
//Net Defination
//////////////////////////////////////////////////////////////////////////
SOCKET server_socket=INVALID_SOCKET ;
SOCKADDR_IN server_addr ;
SOCKADDR_IN client_addr ;
SOCKET client_socket=INVALID_SOCKET;
int err=0;
int server_port =51423;
int addrlen=sizeof(SOCKADDR_IN);
char recv_buf[1024]={0};
char send_buf[1024]={0};
bool sayhi =true;
//////////////////////////////////////////////////////////////////////////


bool game_run = true;

int server_process(char buffer[],int len)
{
	int err=0;
	std::cout<<"RECIEVE:"<<buffer<<std::endl;
	if(strcmp(buffer,"Bye")==0)
	{

		return err =SOCKET_ERROR;
	}
	char send_buf[1024]={0};
	sprintf(send_buf,"%s:%d said: %s",inet_ntoa(client_addr.sin_addr),ntohs(client_addr.sin_port),recv_buf);
	//sprintf(send_buf,"hello this world");
	std::cout<<"SEND:"<<send_buf<<std::endl;
	err = send(client_socket,send_buf,strlen(send_buf)+1,0);
	return err;
}

void main()
{
	init_net_();

	/**
	game part
	*/

	//////////////////////////////////////////////////////////////////////////
	server_socket = socket(AF_INET,SOCK_STREAM,0);
	if(INVALID_SOCKET ==server_socket)
	{
		std::cout<<"socket error: "<<WSAGetLastError()<<std::endl;
		exit_net_();
		return;
	}
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(server_port);
	server_addr.sin_addr.S_un.S_addr = htonl(INADDR_ANY);
	//////////////////////////////////////////////////////////////////////////
	err=bind(server_socket,(SOCKADDR*)&server_addr,sizeof(server_addr));
	if(SOCKET_ERROR == err)
	{
		std::cout<<"bind error:"<<WSAGetLastError()<<std::endl;
		exit_net_();
		return;
	}
	//////////////////////////////////////////////////////////////////////////
	err= listen(server_socket,SOMAXCONN);
	if(SOCKET_ERROR == err)
	{
		std::cout<<"bind error:"<<WSAGetLastError()<<std::endl;
		exit_net_();
		return;
	}
	std::cout<<"Start listening on port:"<<ntohs(server_addr.sin_port)<<std::endl;
	//////////////////////////////////////////////////////////////////////////
	//这里没有涉及到是否退出，作为一个服务器，应该永远走下去
	while(game_run)
	{
		if(client_socket==INVALID_SOCKET)
		{
			client_socket = accept(server_socket,(SOCKADDR*)&client_addr,&addrlen);
			std::cout<<inet_ntoa(client_addr.sin_addr)<<":"<<ntohs(client_addr.sin_port)<<"connected!"<<std::endl;
		}
		if (INVALID_SOCKET !=client_socket)
		{
			if(sayhi)
			{
				sprintf(send_buf,"hello this world");
				std::cout<<"SEND:"<<send_buf<<std::endl;
				err = send(client_socket,send_buf,strlen(send_buf)+1,0);
				if (SOCKET_ERROR == err)
				{
					std::cout<<"process error: "<<WSAGetLastError()<<std::endl;

				}
				sayhi = false;
			}
			err = recv(client_socket,recv_buf,sizeof(recv_buf),0);
			if(err <=0)
			{
				//std::cout<<"recv error: "<<WSAGetLastError()<<std::endl;
			}
			else
			{
				err = server_process(recv_buf,1024);
				if (SOCKET_ERROR == err)
				{
					std::cout<<"process error: "<<WSAGetLastError()<<std::endl;
					if(strcmp(recv_buf,"Bye")==0)
					{
						std::cout<<inet_ntoa(client_addr.sin_addr)<<":"<<ntohs(client_addr.sin_port)<<"left"<<std::endl;
						err= closesocket(client_socket);
						if(SOCKET_ERROR == err)
						{
							std::cout<<"closesocket error: "<<WSAGetLastError()<<std::endl;
						}
						break;
					}
					//break;
				}
				//else
				//{
				//	std::cout<<inet_ntoa(client_addr.sin_addr)<<":"<<ntohs(client_addr.sin_port)<<"left"<<std::endl;
				//	err= closesocket(client_socket);
				//	if(SOCKET_ERROR == err)
				//	{
				//		std::cout<<"closesocket error: "<<WSAGetLastError()<<std::endl;
				//	}
				//}

			}
		}
		else
		{
			std::cout<<"accpet error: "<<WSAGetLastError()<<std::endl;
		}
	}

	//////////////////////////////////////////////////////////////////////////
	std::cout<<inet_ntoa(client_addr.sin_addr)<<":"<<ntohs(client_addr.sin_port)<<"left"<<std::endl;
	err= closesocket(client_socket);
	if(SOCKET_ERROR == err)
	{
		std::cout<<"closesocket error: "<<WSAGetLastError()<<std::endl;
	}
	exit_net_();
	return;

}
