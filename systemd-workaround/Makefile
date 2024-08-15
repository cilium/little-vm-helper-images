
CC=gcc
CFLAGS=-Wall -O2

.PHONY: all
all: systemd-pidfd-fix.so

systemd-pidfd-fix.so: systemd-pidfd-fix.c
	$(CC) $(CFLAGS) -ldl -fPIC -shared -o $@ $<

.PHONY: clean
clean:
	rm -f systemd-pidfd-fix.so
