// #include <WinSock2.h>
// #include <iostream>
// #pragma comment(lib, "ws2_32.lib")
// #include <time.h>
// #include <vector>
// #include <assert.h>
#pragma once
#include "ByteM.h"
#include <vector>
#include <WinSock2.h>


using namespace std;
//通过指针来内存管理




class MessageM
{


public:
	unsigned int crc;
	int size;
	unsigned char mark;//0 有时间 1 没时间 2 分包 3 带时间的分包 
	int token;
	int msgType;


	int client_time;//请注意赋值
	int server_time;
	unsigned char  package_num;
	unsigned char  package_total;

	//std::vector<unsigned char>* message;
	BytesM * message;

	static int create;
	static int distroy;
	static int distroyTimes();		
	static int createTimes();
	MessageM();	
	~MessageM();
	void setMark(int i);
	void SendMessageM(SOCKET s);
	static void MakeMessageM(void* data,int size,std::vector<MessageM*>* msgCollecter,unsigned char mark=0,int msgType=0);
	static MessageM* readMessageM(SOCKET s);	
	void printf();
private:
	static char* recvData(SOCKET s,int size);
	int checkBigEndian(int mark);//返回1 表示读取正确，小端，返回0 表示读取错误 ，大端，返回-1 表示不知道结果，这个需要进行错误处理
};
