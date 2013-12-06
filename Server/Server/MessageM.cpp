#include "MessageM.h"
#include "MathM.h"
extern int globalCrc;
extern int getCrc();
extern int serverBaseTime;
extern int getServerTime();

int  MessageM::create=0;
int  MessageM::distroy=0;
int  MessageM::distroyTimes()
{
	return MessageM::distroy;
}
int  MessageM::createTimes()
{
	return MessageM::create;
}
MessageM::MessageM()
{
	package_total =1;
	client_time =0;
	server_time =getServerTime();
	message = new BytesM();
	create++;
}
MessageM::~MessageM()
{
	if(message)
	{
		delete message;
	}
	distroy++;
}
void  MessageM::setMark(int i)
{
	this->mark = i;
	switch(i)
	{
		case 0:
			client_time =0;
			server_time = getServerTime();
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:
			client_time =0;
			server_time = getServerTime();
			break;

	}
}
void  MessageM::SendMessageM(SOCKET s)
{
	int len = this->size+27;
	BytesM * data = new BytesM(len);
	data->writeUnsignedInt(this->crc);
	data->writeInt(this->size);
	data->writeUnsignedByte(this->mark);
	data->writeInt(this->msgType);
	data->writeInt(this->token);
	switch(this->mark)	
	{
		case 0:
			data->writeInt(client_time);
			data->writeInt(server_time);		
			break;
		case 1:
			break;
		case 2:
			data->writeByte(this->package_total);
			data->writeByte(this->package_num);
			break;
		case 3:
			data->writeInt(client_time);
			data->writeInt(server_time);
			data->writeUnsignedByte(this->package_total);
			data->writeUnsignedByte(this->package_num);
			break;

	}
	data->writeBytes(this->message,0,this->message->size());
	send(s,data->getData(),data->size(),0);//这里要注意是否真的需要加1
	delete data;
}
void  MessageM::MakeMessageM(void* data,int size,std::vector<MessageM*>* msgCollecter,unsigned char mark,int msgType)
{
	//按3000字节计算
	int crc = getCrc();
	int total = (int)(std::ceil((double)size/(double)3000));
	int currentSize=0;
	int currentNum=0;
	if(size<3000)
	{
		MessageM* msg = new MessageM();
		msg->mark = mark;
		msg->crc = crc;
		msg->client_time = 0;
		msg->server_time = getServerTime();
		msg->msgType = msgType;
		msg->package_total =1;
		msg->size =size;		
		msg->message ->writeBytesChar((char*)data,0,size);
		msgCollecter->push_back(msg);
		return;
	}
	while(size!=currentSize)
	{
		MessageM * msg = new MessageM();
		msg->mark = mark;
		msg->crc = crc;
		msg->client_time = 0;
		msg->server_time = getServerTime();
		msg->msgType = msgType;
		msg->package_total =total;
		if(size-currentSize<=3000)
		{
			msg->size  =size - currentSize;
			currentSize += size -currentSize;
			msg->message->writeBytesChar((char*)data,currentSize,size-currentSize);
			msg->package_num = currentNum;
			currentNum+=1;

		}
		else
		{
			msg->message->writeBytesChar((char*)data,currentSize,3000);
			currentSize+=3000;
			msg->size =3000;
			msg->package_num = currentNum;
			currentNum+=1;
		}
		msgCollecter->push_back(msg);
	}
	if(currentNum!=total-1)
	{
		//报错
		std::cout<<"Error: Message total is wrong"<<std::endl;

	} 

}
MessageM*  MessageM::readMessageM(SOCKET s)
{
	char* data = recvData(s,17);
	if(!data)
		return NULL;
	//这里要大端转换
	MessageM * message = new MessageM();
	message->crc =readUnsignedIntS(data,0,17);
	message->size =readIntS(data,4,17);
	message->mark = readUnsignedChar(data,8,17);
	message->msgType =readIntS(data,9,17);
	message->token =readIntS(data,13,17);

	if(message->mark>3||message->mark<0)
	{
		recvData(s,1000);
		return NULL;
	}

	switch (message->mark)
	{
	case 0 :
		{
			delete data;
			data = recvData(s,8);
			if(!data)
			{
				delete message; 
				std::cout<<"Read Error:Length is short"<<std::endl;
				return NULL;
			}
			message->client_time = readIntS(data,0,8);
			message->server_time = readIntS(data,4,8);			 

		}
		break;
	case 1:
		{
			message->package_total=1;
			message->package_num =0;
		}
		break;
	case 2:
		{
			delete data;
			data = recvData(s,2);
			if(!data)
			{
				delete message; 
				std::cout<<"Read Error:Length is short"<<std::endl;
				return NULL;
			}				 
			message->package_total = readUnsignedChar(data,0,2);
			message->package_num = readUnsignedChar(data,1,2);
		}
		break;
	case 3:
		{
			delete data;
			data = recvData(s,10);
			if(!data)
			{
				delete message; 
				std::cout<<"Read Error:Length is short"<<std::endl;
				return NULL;
			}	 
			message->client_time = readIntS(data,0,10);
			message->server_time = readIntS(data,4,10);
			message->package_total = readUnsignedChar(data,8,10);
			message->package_num = readUnsignedChar(data,9,10);

		}
		break;				
	}
	if(data!=NULL)
	{
		delete data;
	}
	data = recvData(s,message->size);
	if(!data)
	{
// 		delete message; 
// 		std::cout<<"Read Error:Length is short"<<std::endl;
// 		return NULL;
	} 
	message->message->writeBytesChar(data,0,message->size);		
	return message;
}
void  MessageM::printf()
{
	std::cout<<"crc："<<this->crc<<std::endl;
	std::cout<<"size:"<<this->size<<std::endl;
	std::cout<<"mark:"<<(int)this->mark<<std::endl;
	std::cout<<"MessageType:"<<this->msgType<<std::endl;
	std::cout<<"token"<<this->token<<std::endl;
	std::cout<<"client time:"<<(int)this->client_time<<std::endl;
	std::cout<<"server time:"<<(int)this->server_time<<std::endl;
	std::cout<<"package total:"<<(int)this->package_total<<std::endl;
	std::cout<<"package number:"<<(int)this->package_num<<std::endl;
	std::cout<<"Message:"<<std::hex<<readIntS(message->getData(),0,message->size())<<std::endl;

}
char* MessageM::recvData(SOCKET s,int size)
{
	char* data =new char[size];
	int bufLen = recv(s,data,size,0);
	if(bufLen<0)
	{
		//无数据可读
		delete data;
		std::cout<<"ERROR:获得了:"<<bufLen<<"个字节"<<endl;

		if(errno != EAGAIN)
		{

			return NULL;		
		}
		return NULL;
	}
	else if(bufLen==0)
	{
		//客户端关闭
		delete data;
		std::cout<<"ERROR:获得了:"<<bufLen<<"个字节"<<endl;
		return NULL;

	}
	else
	{
		if(bufLen ==size)
			return data;
		else
		{
			std::cout<<"ERROR:获得了:"<<bufLen<<"个字节"<<endl;
			return NULL;
		}
	}
}
int MessageM::checkBigEndian(int mark)
{
	return 1;
}




