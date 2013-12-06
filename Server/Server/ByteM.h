#pragma once
#include <iostream>
#include <assert.h>
using namespace std;

class BytesM 
{
private :
	enum RW{Write,Read} ;
	char* message;
	int _size;
	int currentWritePos;
	int currentReadPos;
	int capacity;
public :
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
static int readInt(char*data , int offset,int size)
{
	int i=0;
	if(size>=offset+4)
	{
		memcpy(&i,data+offset,4);
		return i;
	}
	else
	{
		//报错
		return -1;
	}


}
static unsigned int readUnsignedInt(char*data,int offset,int size)
{
	unsigned int i=0;
	if(size>=offset+4)
	{
		memcpy(&i,data+offset,4);
		return i;
	}
	else
	{
		//报错
		return -1;
	}
}
static unsigned char  readUnsignedChar(char* data,int offset,int size)
{
	unsigned char i=0;
	if(size>=offset+1)
	{
		memcpy(&i,data+offset,1);
		return i;
	}
	else
	{
		//报错
		return -1;
	}
}
static char readChar(char*data,int offset,int size)
{
	char i=0;
	if(size>=offset+1)
	{
		memcpy(&i,data+offset,1);
		return i;
	}
	else
	{
		//报错
		return -1;
	}

}
static double readDouble(char* data,int offset,int size)
{
	double i=0;
	if(size>=offset+8)
	{
		memcpy(&i,data+offset,8);
		return i;
	}
	else
	{
		//报错
		return -1;
	}

}


