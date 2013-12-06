
#include "MessageMArray.h"
 

 
	 int MessageMArray::create =0;
	 int MessageMArray::distroy =0;
	int MessageMArray::distroyTimes()
	{
		return MessageMArray::distroy;
	}
	 int  MessageMArray::createTimes()
	{
		return MessageMArray::create;
	}
	

	MessageMArray::MessageMArray()
	{
		package_total=0;
		main_message = new BytesM();
		messages = new std::vector<MessageM*>();
		currentNum =0;
		create++;

	}
	 MessageMArray::~MessageMArray()
	{
		if(main_message)
		{
			delete main_message;
		}
		if(messages)
		{
			for(int i=0;i<messages->size();i++)
			{
				delete messages->at(i);

			}
			delete messages;
		}
		distroy++;

	}

	MessageM*  MessageMArray::readMessage(MessageM* msg)
	{
		//MessageM* returnMsg;
		if(this->package_total==0)
		{
			std::cout<<"first insert"<<std::endl;
			this->crc = msg->crc;
			this->mark = msg->mark;
			this->msgType = msg->msgType;
			this->token = msg->token;
			this->package_total = msg->package_total;
			this->client_time = msg->client_time;
			this->server_time = msg->server_time;
			if(currentNum == msg->package_num)
			{
				main_message->writeBytes(msg->message,0,msg->message->size());
				currentNum+=1;
				delete msg;//删除msg
			}
			else
			{
				messages->push_back(msg);
			}
			std::cout<<"Message is not complete"<<std::endl;
			return NULL;
		}
		else
		{
			if(currentNum == msg->package_num)
			{
				main_message->writeBytes(msg->message,0,msg->message->size());
				currentNum+=1;
				
				bool readed=false;
				do
				{
					readed = check();
				}while(readed);
				if(currentNum == this->package_total)
				{
					msg->package_total=1;
					msg->size = main_message->size();
					msg->client_time = this->client_time;
					msg->server_time = this->server_time;
					if(msg->message)
						delete msg->message;
					msg->message = this->main_message;//这里要主要，删除内存要放到外面
					return msg;
				}
				delete msg;
				return NULL;
			}
			else
			{
				messages->push_back(msg);
				return NULL;
			}

		}
 
		
}
		

 

	/* 
	查找是否可以继续叠加 
	*/
	bool  MessageMArray::check()
	{
		std::vector<MessageM*>::iterator it = messages->begin();
		int i=0;
		for(;it<messages->end();i++,it++)
		{
			if((*it)->package_num == currentNum)
			{

				main_message->writeBytes((*it)->message,0,(*it)->message->size());
				delete messages->at(i);
				messages->erase(it);
				currentNum+=1;
				return true;
			}
		}
		return false;

	}
