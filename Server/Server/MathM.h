
#include <iostream>
using namespace std;
// char[4] \x90 \x96 \09 \x95 ====> int 0x90 96 09 95
static int readIntS(char*data , int offset,int size)
{
	int i=0;
	if(size>=offset+4)
	{
		i= (data[offset]<<24)+(data[offset+1]<<16)+(data[offset+2]<<8)+(data[offset+3]);
		return i;
	}
	else
	{
		//±¨´í
		return -1;
	}


}
static unsigned int readUnsignedIntS(char*data,int offset,int size)
{
	unsigned int i=0;
	if(size>=offset+4)
	{
		i= (data[offset]<<24)+(data[offset+1]<<16)+(data[offset+2]<<8)+(data[offset+3]);
		return i;
	}
	else
	{
		//±¨´í
		return -1;
	}
}
 
 
static double readDoubleS(char* data,int offset,int size)
{
	double i=0;
	if(size>=offset+8)
	{
		i= ((long long)data[offset]<<56)+((long long)data[offset+1]<<48)+((long long)data[offset+2]<<40)+((long long)data[offset+3]<<32)+\
			((long long)data[offset+4]<<24)+((long long)data[offset+5]<<16)+((long long)data[offset+6]<<8)+(long long)data[offset+7];
		return i;
	}
	else
	{
		//±¨´í
		return -1;
	}
}