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
//ͨ��ָ�����ڴ����




class MessageM
{


public:
	unsigned int crc;
	int size;
	unsigned char mark;//0 ��ʱ�� 1 ûʱ�� 2 �ְ� 3 ��ʱ��ķְ� 
	int token;
	int msgType;


	int client_time;//��ע�⸳ֵ
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
	int checkBigEndian(int mark);//����1 ��ʾ��ȡ��ȷ��С�ˣ�����0 ��ʾ��ȡ���� ����ˣ�����-1 ��ʾ��֪������������Ҫ���д�����
};
