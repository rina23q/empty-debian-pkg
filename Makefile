CC:=gcc
CFLAGS:=-g
RM:=rm -rf

STAGE_DIR:=build/staging

default: all

all: hello debian

hello: src/hello.c
	@mkdir -p bin
	@$(CC) $(CFLAGS) -o bin/hello src/hello.c

debian:
	mkdir -p $(STAGE_DIR)/usr/bin
	cp bin/hello $(STAGE_DIR)/usr/bin
	cp -r debian/DEBIAN $(STAGE_DIR)
	find $(STAGE_DIR) -type d | xargs chmod 755
	fakeroot dpkg-deb --build $(STAGE_DIR) build

clean:
	@$(RM) bin
