#include <stdio.h>
char *QJ = "1";//ǰ��
char *BJ = "0";//����
int isHANZI(unsigned char *word);
void showHANZImod(unsigned char *word);
void showASCmod(unsigned char *word);
int main(int argc, char **argv)
{
	unsigned char *word = argv[1];
	if(isHANZI(word))
		showHANZImod(word);
	else
		showASCmod(word);
	return 0;
}
void showHANZImod(unsigned char *word)
{
	unsigned char buffer[32];
	unsigned char i,j;
	long int offset = (94*(unsigned int)(word[0]-0xA0-1)+(word[1]-0xA0-1))*32;
	printf("#��ǰ����������:%s\n", word);
	printf("#����:%d λ��:%d\n", word[0], word[1]);
	printf("#ƫ��ֵΪ: %ld\n", offset);
	FILE *fphzk = fopen("HZK16", "rb");
	if (fphzk == NULL) {
		printf("#���ֿ�ʧ��\n");
		return;
	}
	fseek(fphzk, offset, 0);
	fread(buffer, 32, 1, fphzk);
	for (i = 0; i < 32; i++) {
		for (j = 0; j < 8; j++) {
			if (buffer[i] & 0x80)
				printf("%s", QJ);
			else
				printf("%s", BJ);
			buffer[i] <<= 1;
		}
		if (i % 2) printf("\n");
	}
	fclose(fphzk);
}
void showASCmod(unsigned char *word)
{
	unsigned char buffer[16];
	unsigned char i,j;
	long int offset = *word*16+1;
	printf("#��ǰ�������ַ�:%s\n", word);
	printf("#ƫ��ֵΪ: %ld\n", offset);
	FILE *fpasc = fopen("ASC16", "rb");
	if (fpasc == NULL) {
		printf("#���ֿ�ʧ��\n");
		return;
	}
	fseek(fpasc, offset, 0);
	fread(buffer, 16, 1, fpasc);
	for(i=0; i<16; i++) {
		for(j=0; j<8; j++)
			if(buffer[i]&(0x80>>j))
				printf("%s", QJ);
			else
				printf("%s", BJ);
		printf("\n");
	}
	fclose(fpasc);
}
int isHANZI(unsigned char *word)
{
	return word[1] < 128 ? 0 : 1;
}
