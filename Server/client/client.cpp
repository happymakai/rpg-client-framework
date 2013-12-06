#include "../lib/lib.h"

//////////////////////////////////////////////////////////////////////////
//Net Defination
//////////////////////////////////////////////////////////////////////////
//SOCKET server_socket=0 ;
SOCKADDR_IN server_addr ;
SOCKADDR_IN client_addr ;
SOCKET client_socket=0;
int err=0;
int server_port =9999;
int addrlen=sizeof(SOCKADDR_IN);
char recv_buf[1024]={0};
char send_buf[1024]={0};
//wchar_t err_msg[1024];
static DWORD time_count=0;
bool sayhi = true;
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////////
bool game_run = true;
HINSTANCE g_hInstance =NULL;
HWND g_hWnd = NULL;
int g_nCmdShow =0;
#define KEY_DOWN(vk) ((GetAsyncKeyState(vk) & 0x8000)?1:0)
//////////////////////////////////////////////////////////////////////////

int client_process(char buffer[],int len)
{
	int err;
	std::cout<<"RECIEVED:"<<buffer<<std::endl;

	char send_buf[1024]={0};
	sprintf(send_buf,"Now Time is %d",GetTickCount());
	err = send(client_socket, send_buf, strlen(send_buf) + 1, 0);  
	if ( SOCKET_ERROR == err )  
	{  
		std::cout<<"send error: "<<WSAGetLastError()<<std::endl;  
	}  
	return err;
}

LRESULT WINAPI WinProc( HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam )
{
	switch( msg )
	{
		//case WM_QUIT:
	case WM_DESTROY:
		{
			{
				sprintf(send_buf,"Bye");
				err = send(client_socket,send_buf,strlen(send_buf)+1,0);
				if ( SOCKET_ERROR == err )  
				{ 
					std::cout<<"send error: "<<WSAGetLastError()<<std::endl;  
				}  
				err = closesocket(client_socket);  
				if ( SOCKET_ERROR == err )  
				{  
					std::cout<<"closesocket error: "<<WSAGetLastError()<<std::endl;  
				}  
			}
			PostQuitMessage(0);
			return (0);
		}
		break;
	}
	return DefWindowProc( hWnd, msg, wParam, lParam );
}

int WINAPI WinMain( __in HINSTANCE hInstance, __in_opt HINSTANCE hPrevInstance, __in LPSTR lpCmdLine, __in int nShowCmd )
{

	MSG msg;
	::ZeroMemory(&msg, sizeof(MSG));
	srand((unsigned int)time(NULL));
	g_hInstance = hInstance;
	g_nCmdShow = nShowCmd;
	AllocConsole();
	freopen("CONOUT$", "w+t", stdout);
	DWORD dwStyle;


	//////////////////////////////////////////////////////////////////////////
	//Init net
	//////////////////////////////////////////////////////////////////////////
	init_net_();
	client_socket= socket(AF_INET,SOCK_STREAM,0);
	if(INVALID_SOCKET == client_socket)
	{
		std::cout<<"socket error: "<<WSAGetLastError()<<std::endl;
		exit_net_();
		return 0;
	}

	SOCKADDR_IN server_addr;
	server_addr.sin_family =AF_INET;
	server_addr.sin_port = htons(server_port);
	server_addr.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");

	err = connect(client_socket,(SOCKADDR*)&server_addr,sizeof(server_addr));
	if(SOCKET_ERROR == err)
	{
		std::cout<<"connect error:"<<WSAGetLastError()<<std::endl;
		exit_net_();
		return 0;
	}

	std::cout<<"Connection established."<<std::endl;




	wchar_t title[255]=L"Hello goodbye and Hello";
	WNDCLASSEX wc;
	wc.cbSize = sizeof(WNDCLASSEX); 

	//fill the struct with info
	wc.style		 = CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc   = (WNDPROC)WinProc;
	wc.cbClsExtra	 = 0;
	wc.cbWndExtra	 = 0;
	wc.hInstance	 = hInstance;
	wc.hIcon		 = NULL;
	wc.hCursor	   = LoadCursor(NULL, IDC_ARROW);
	wc.hbrBackground = NULL;
	wc.lpszMenuName  = NULL;
	wc.lpszClassName = title;
	wc.hIconSm	   = LoadIcon(NULL,IDI_APPLICATION);


	//set up the window with the class info
	RegisterClassEx(&wc);

	dwStyle = WS_EX_TOPMOST|WS_OVERLAPPEDWINDOW | WS_VISIBLE;

	g_hWnd = CreateWindowEx( 0,
		title,			//window class
		title,			//title bar
		dwStyle,		//dwStyle | WS_CLIPCHILDREN | WS_CLIPSIBLINGS
		0, 0,			//x,y coordinate
		640,			//width of the window
		480,			//height of the window
		0,				//parent window
		0,				//menu
		g_hInstance,	//application instance
		0);				//window parameters

	if (!g_hWnd) 	
	{
		MessageBox(g_hWnd, L"Error creating program window!", L"Error", MB_OK);
		return 0; 
	}

	//display the window
	ShowWindow(g_hWnd, g_nCmdShow);
	UpdateWindow(g_hWnd);
	//////////////////////////////////////////////////////////////////////////

	time_count = GetTickCount();
	while (msg.message!=WM_QUIT)
	{
		while (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) 
		{

			TranslateMessage(&msg);
			DispatchMessage(&msg);

		}
		if((GetTickCount()-time_count)>200)
		{
			time_count = GetTickCount();
// 			if(msg.message==WM_DESTROY)


			if (KEY_DOWN(VK_ESCAPE))
				::SendMessage(g_hWnd,WM_CLOSE,0,0);
			if(sayhi)
			{
				sprintf(send_buf,"Now Time is %d",GetTickCount());
				err = send(client_socket, send_buf, strlen(send_buf) + 1, 0);  
				if ( SOCKET_ERROR == err )  
				{  
					std::cout<<"send error: "<<WSAGetLastError()<<std::endl;  
				} 
				sayhi =false;
			}


			err= recv(client_socket,recv_buf,sizeof(recv_buf),0);
			if ( err <= 0 )  
			{  
				//std::cout<<"recv error: "<<WSAGetLastError()<<std::endl;  
			} 
			else
			{
				err=client_process(recv_buf,1024);
			}
		}

	}

	FreeConsole();
	exit_net_();

	return 0;
}