#include <iostream>

using namespace std;

extern "C"
{
	char *my_strcpy(char* dst, char* src, int len);
}
int my_strlen(char *str)
{
	int len = 0;
	__asm
	{
		mov ecx,0
		not ecx
		mov al,'\0'
		mov edi,str
		repne scasb
		not ecx
		dec ecx
		mov len,ecx
	}
	return len;
}

int main()
{
	char str1[20] = "testtesttest", str2[10] = "67890";
	cout << my_strlen(str1) << endl;
	my_strcpy(str1 + 2, str1, 3);
	for (int i = 0; i < my_strlen(str1); i++)
		cout << str1[i];
	cout << endl;
}

