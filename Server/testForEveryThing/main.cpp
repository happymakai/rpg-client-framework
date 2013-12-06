#include <iostream>
#include "ByteM.h"
#include "../Server/MathM.h"
using namespace std;

 

void main()
{
//    BytesM * bm = new BytesM();
//    unsigned char a =2;
//    char b=3;
//    int c =4;
//    unsigned int d =5;
//    char* e="hello";
// 
//    bm->writeUnsignedByte(a);
//    bm->writeByte(b);
//    bm->writeInt(c);
//    bm->writeUnsignedInt(d);
//    bm->writeBytesChar(e,0,6);
//    
//    std::cout<<"a:"<<bm->readUnsignedByte()<<std::endl;
//    std::cout<<"b:"<<bm->readByte()<<std::endl;
//    std::cout<<"c:"<<bm->readInt()<<std::endl;
//    std::cout<<"d:"<<bm->readUnsignedInt()<<std::endl;
//    char * f;
//    f= bm->readBytesChar(0,6);
//    std::cout<<"e:"<<f<<std::endl;
//    std::cout<<"size:"<<bm->size()<<std::endl;
// 
//    delete bm;
	char shu[8]={0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08};
 
	double c=0;
	
	//memcpy(&i,shu,sizeof(i));
	memcpy(&c,shu,8);
	double i =0x0102030405060708;

	std::cout<<std::hex<<i<<endl;//<<"i:10:"
	std::cout<<std::hex<<c<<endl;//<<"c:10:"
	std::cout<<std::hex<<readDoubleS(shu,0,8)<<std::endl;//<<"shu:10:"
   while(1);
}