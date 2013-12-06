#pragma once


#include "ByteM.h"
#include "MessageM.h"
#include "MessageMArray.h"


class MessageManager
{

public:
	MessageManager()
	{
		msgArray = new std::vector<MessageMArray*>();
	}
	~MessageManager()
	{
		if(msgArray)
		{
			for (int i=0;i<msgArray->size();i++)
			{
				if(msgArray->at(i))
					delete msgArray->at(i);
			}
			delete msgArray;
		}
	}
	MessageM* readSocket(SOCKET s)
	{
		MessageM* msg = check(MessageM::readMessageM(s));
		if(msg == NULL)
		{
			std::cout<<"Message is not complete"<<std::endl;
		}
		return msg; 
	}
private:
	MessageM* check(MessageM* msg)
	{
		MessageM * returnMsg;
		if(msg==NULL)
		{
			std::cout<<"Message is NULL"<<std::endl;
			return NULL;
		}
		bool finded= false;
		if(msg->package_total==1||msg->mark==1)
		{

			return msg;
		}
		else
		{
			std::vector<MessageMArray*>::iterator it= msgArray->begin();
			int i =0;
			for( ;it<msgArray->end();it++,i++)
			{
				//MessageMArray * list = it;
				if((*it)->crc==msg->crc)
				{
					returnMsg  = (*it)->readMessage(msg);
					finded = true;
					if(returnMsg==NULL)
					{
						std::cout<<"Message is not complete"<<std::endl;
					}
					else
					{
						std::cout<<"get a message"<<std::endl;
						delete msgArray->at(i);
						msgArray->erase(it);
					}
					return returnMsg;
				}

			}
			if(!finded)
			{
				std::cout<<"Message insert"<<std::endl;
				MessageMArray* arr = new MessageMArray();
				arr->readMessage(msg);
				msgArray->push_back(arr);
			}
			std::cout<<"Message is not complete"<<std::endl;
			return returnMsg=NULL;

		}

	}
private:
	std::vector<MessageMArray*> *msgArray;


};

/***********************************************************************
内存检测：
   manage中 array 的个数加上 array destroy 的个数 等于array create的个数
   array中message的总个数 加上message destroy的个数 等于message create的个数
   message 的总个数 加上 bytesM destroy的个数 等于 bytesM create的个数

Message可以是链表的形式

大端小端的问题 
默认小端，客户端为大端

msg.client time 要赋值
 ***********************************************************************/




