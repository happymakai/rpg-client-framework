#pragma once
#include <iostream>
#include <assert.h>
using namespace std;

class BytesM 
{
private :
	
	char* message;
	int _size;
	int currentWritePos;
	int currentReadPos;
	int capacity;
public :
	enum RW{Write,Read} ;
	static int create;
	static int distroy;
	//构造函数
	BytesM();
	~BytesM();
	BytesM(int size);
	int size();
 
	char  readByte();
	unsigned char readUnsignedByte();

	int readInt();
	unsigned int readUnsignedInt();
	
	BytesM* readBytes(int offset=0,int size=0);
	char* readBytesChar(int offset=0 , int size=0);

	void writeByte(char cbyte);
	void writeUnsignedByte(unsigned char cbyte);	

	void writeInt(int i);
	void writeUnsignedInt(unsigned int i);

	void writeBytesChar(char* bm,int offset=0,int size =0);
	void writeBytes(BytesM* bm,int offset =0,int size=0 );


	char * getData();
	static int distroyTimes();
	static int createTimes();
	//size的大小等于currentWritePos-currentReadPos
private:
	bool test(int size,RW type=BytesM::Read);
};


