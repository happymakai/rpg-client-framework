#include <assert.h>
//TODO:
//http://www.cppblog.com/beautykingdom/archive/2009/12/07/102753.aspx
//值得注意的是指针类型 32位为4 64位为8
#define  _SYSTEM_32_
#ifndef _SYSTEM_32_

typedef char c8;
typedef unsigned char u8;
typedef int c32;
typedef unsigned int u32;
typedef double  f64;
typedef float   f32;

#else 
typedef char c8;
typedef unsigned char u8;
typedef int c32;
typedef unsigned int u32;
typedef double  f64;
typedef float   f32;
#endif

void testType()
{
#ifdef _SYSTEM_32_
	assert(sizeof(c8)==1);
	assert(sizeof(u8)==1);
	assert(sizeof(c32)==4);
	assert(sizeof(u32)==4);
	assert(sizeof(f32)==4);
	assert(sizeof(f64)==8);
#else
	assert(sizeof(c8)==1);
	assert(sizeof(u8)==1);
	assert(sizeof(c32)==4);
	assert(sizeof(u32)==4);
	assert(sizeof(f32)==4);
	assert(sizeof(f64)==8);
#endif // _DEBUG
}