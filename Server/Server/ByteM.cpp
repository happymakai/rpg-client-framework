#include "ByteM.h"

int BytesM::readInt()
{
	assert((currentWritePos-currentReadPos)==_size);
	bool readable = test(4,BytesM::Read);
	if(!readable)
	{
		std::cout<<"读取错误"<<std::endl;
		return -1;
	}
	assert(sizeof(int)==4);
	int i=0; 
	memcpy(&i,this->message+currentReadPos,4);
	currentReadPos+=4;
	this->_size-=4;		
	return i;
}

int BytesM::size()
{

	return this->_size;
}


BytesM* BytesM::readBytes(int offset,int size)
{
	assert((currentWritePos-currentReadPos)==_size);
	bool readable = test(offset+size);
	if(!readable)
	{
		return NULL;
	}
	BytesM * bm = new BytesM();
	bm->writeBytes(this,offset,size);
	this->currentReadPos+=(offset+size);
	_size-=offset+size;
	return bm;
}

unsigned int BytesM::readUnsignedInt()
{
	assert((currentWritePos-currentReadPos)==_size);
	bool readable = test(4);
	if(!readable)
		return -1;
	unsigned int i=0;
	memcpy(&i,message+currentReadPos,4);
	currentReadPos+=4;
	_size-=4;
	return i;
}
char  BytesM::readByte()
{
	assert((currentWritePos-currentReadPos)==_size);
	bool readable = test(1);
	if(!readable)
		return -1;
	char i;
	memcpy(&i,message+currentReadPos,1);
	currentReadPos+=1;
	_size-=1;
	return i;
}
unsigned char BytesM::readUnsignedByte()
{
	assert((currentWritePos-currentReadPos)==_size);
	bool readable = test(1);
	if(!readable)
		return -1;
	unsigned char i;
	memcpy(&i,message+currentReadPos,1);
	currentReadPos+=1;
	_size-=1;
	return i;

}

char* BytesM::readBytesChar(int offset , int size)
{
	assert((currentWritePos-currentReadPos)==_size);
	bool readable = test(offset+size);
	if(!readable)
		return NULL;
	char* data = new char[size];
	memcpy(data,message+currentReadPos+offset,size);
	currentReadPos+=offset+size;
	_size-=offset+size;
	return data;

}

void BytesM::writeInt(int i)
{
	assert((currentWritePos-currentReadPos)==_size);
	bool writable =test(4,BytesM::Write);
	memcpy(message+currentWritePos,&i,4);
	currentWritePos+=4;
	_size+=4;

}
void BytesM::writeUnsignedInt(unsigned int i)
{
	assert((currentWritePos-currentReadPos)==_size);
	bool writable =test(4,BytesM::Write);
	memcpy(message+currentWritePos,&i,4);
	currentWritePos+=4;
	_size+=4;
}

void BytesM::writeUnsignedByte(unsigned char cbyte)
{
	assert((currentWritePos-currentReadPos)==_size);
	bool writable  =test(1,BytesM::Write);
	memcpy(message+currentWritePos,&cbyte,1);
	currentWritePos+=1;
	_size+=1;
}

void BytesM::writeByte(char cbyte)
{
	assert((currentWritePos-currentReadPos)==_size);
	bool writable  =test(1,BytesM::Write);
	memcpy(message+currentWritePos,&cbyte,1);
	currentWritePos+=1;
	_size+=1;
}
void BytesM::writeBytes(BytesM* bm,int offset ,int size)
{
	assert((currentWritePos-currentReadPos)==_size);
	char *data = bm->getData();
	test(size,BytesM::Write);
	memcpy(message+currentWritePos,data+bm->currentReadPos+offset,size);
	currentWritePos+=size;		
	_size+=size;
}
void BytesM::writeBytesChar(char* bm,int offset,int size)
{
	assert((currentWritePos-currentReadPos)==_size);
	test(size,BytesM::Write);
	memcpy(message+currentWritePos,bm+offset,size);
	currentWritePos+=size;
	_size+=size;
}








BytesM::BytesM()
{
	message = new char[100];
	this->_size=0;
	this->capacity=100;
	currentReadPos = 0;
	currentWritePos =0;
	BytesM::create++;
}
BytesM::~BytesM()
{
	if(message)
		delete message;
	BytesM::distroy++;

}
BytesM::BytesM(int size)
{
	message = new char[size+100];
	this->_size = 0;
	this->capacity =100+size;
	currentReadPos = 0;
	currentWritePos =0;
	BytesM::create++;
}
char * BytesM::getData()
{
	//return this->message;
	char *data = new char[this->_size];
	memcpy(data,message+currentReadPos,this->_size);
	//这里不影响size的大小
	return data;
}

 int BytesM::distroyTimes()
{
	return BytesM::distroy;
}
 int BytesM::createTimes()
{
	return BytesM::create;
}
//size的大小等于currentWritePos-currentReadPos

bool BytesM::test(int size,RW type)
{
	if(type == BytesM::Write)
	{
		if(_size ==0)
		{
			currentReadPos=0;
			currentWritePos=0;
			return true;
		}

		if(currentWritePos+size>capacity)
		{
			//要扩大内存
			char * data = new char[this->_size+size+100];
			memcpy(data,message+currentReadPos,this->_size);
			delete message;
			message = data;
			currentReadPos=0;
			currentWritePos=this->_size;
			this->capacity= this->_size+size+100;
		}

		return true;
	}
	else
	{
		if(_size<size)
		{
			//无法读取
			return false;
		}
		return true;
	}

}

int BytesM::distroy =0;
int BytesM::create =0;
