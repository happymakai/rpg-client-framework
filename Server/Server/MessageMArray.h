#pragma  once
#include <vector>
using namespace std;
//ͨ��ָ�����ڴ����



#include "ByteM.h"
#include "MessageM.h"
class MessageMArray
{
public:
	unsigned int crc;
	int size;
	unsigned char mark;
	int token;
	int msgType;
	int client_time;//��ע�⸳ֵ
	int server_time;
	unsigned char  package_num;
	unsigned char  package_total;
	BytesM* main_message;
	std::vector<MessageM*>* messages;
	unsigned char currentNum;
	static int create;
	static int distroy;
	static int distroyTimes();
	static int createTimes();
	MessageMArray();
	~MessageMArray();
	MessageM* readMessage(MessageM* msg);
		

 
private:
	/* 
	�����Ƿ���Լ������� 
	*/
	bool check();
};