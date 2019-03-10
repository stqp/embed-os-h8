PREFIX = /usr/local
ARCH   = h8300-elf
BINDIR = $(PREFIX)/bin
ADDNAME = $(ARCH)-

AR 		  = $(BINDIR)/$(ADDNAME)ar
AS 		  = $(BINDIR)/$(ADDNAME)as
CC 		  = $(BINDIR)/$(ADDNAME)gcc
LD 		  = $(BINDIR)/$(ADDNAME)ld
NM 		  = $(BINDIR)/$(ADDNAME)nm
OBJCOPY = $(BINDIR)/$(ADDNAME)objcopy
OBJDUMP = $(BINDIR)/$(ADDNAME)objdump
RANLIB  = $(BINDIR)/$(ADDNAME)ranlib
STRIP   = $(BINDIR)/$(ADDNAME)strip

H8WRITE = /usr/local/h8write

H8WRITE_SERDEV = /dev/cuad0 #シリアル接続


# コンパイルするソースコード群
OBJS = vector.o startup.o main.o
OBJS += libo serial.o

#生成する実行形式のファイル名
TARGET = kzload

#コンパイルオプション
CLAGS = -Wall -mh -nostdinc -nostdlib -fno-builtin
CFLAGS += -I.
CFLAGS += -Os
CFLAGS += -DKZLOAD

#リンクオプション
LFLAGS = -static -T ld.scr -L.

.SUFFIXES: .c .o
.SUFFIXES: .s .o


all : $(TARGET)

#実行形式の生成ルール
$(TARGET) : $(OBJS)
						$(CC) $(OBJS) -o $(TARGET) $(CFLAGS) $(LFLAGS)
						cp $(TARGET) $(TARGET).elf
						$(STRIP) $(TARGET)

#.cファイルのコンパイルルール
.c.o : $<
			 $(CC) -c $(CFLAGS) $<

#アセンブラファイルのアセンブルルール
.s.o : $<
			 $(CC) -c $(CFLAGS) $<

#モトローラSレコード・フォーマットへの変換
$(TARGET).mot : $(TARGET)
								$(OBJCOPY) -O srec $(TARGET) $(TARGET).mot

image : $(TARGET).mot

#フラッシュROMへの転送
write : $(TARGET).mot
				$(H8WRITE) -3069 -f20 $(TARGET).mot $(H8WRITE_SERDEV)


clean :
	rm -f $(OBJS) $(TARGET) $(TARGET).elf $(TARGET).mot






