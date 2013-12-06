#include <WinSock2.h>
#include <iostream>
#pragma comment(lib, "ws2_32.lib")
#include <time.h>
#include <vector>
#include <assert.h>
using namespace std;
#include "MathM.h"


int init_net_()
{
	WORD wVersionRequested = MAKEWORD(1,1);
	WSADATA wsaData;
	int err = WSAStartup(wVersionRequested,&wsaData);
	if(0!=err)
	{
		std::cout<<"WSAStartup failed.retrun: "<<err<<std::endl;
		return 0;
	}
	if(wsaData.wVersion != wVersionRequested)
	{
		std::cout<<"wsaData.wVersion: "<<wsaData.wVersion
			<< "is not equal to wVersionRequsted: "<<wVersionRequested<<std::endl;
		WSACleanup();
		return 0;
	}
	return 1;
}


void exit_net_()
{
	WSACleanup();
}


int globalCrc = 0x00000001;

bool game_run = true;



int getCrc()
{
	int i = globalCrc;
	globalCrc++;
	return i;
}

int serverBaseTime=1000;
int getServerTime()
{
	return serverBaseTime;
}








