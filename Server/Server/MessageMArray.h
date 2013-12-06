#pragma  once
#include <vector>
using namespace std;
//通过指针来内存管理



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
	int client_time;//请注意赋值
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
	查找是否可以继续叠加 
	*/
	bool check();
};