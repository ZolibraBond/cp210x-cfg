vpath %.c src

OBJS=\
  build/main.o

LIBUSB_CFLAGS=$(shell pkg-config --cflags libusb-1.0 | sed 's:/libusb-1.0::')

CFLAGS=-std=c11 -O2 -pipe -Wall -Wextra -D_POSIX_C_SOURCE=2 $(LIBUSB_CFLAGS) -c
LDFLAGS=$(shell pkg-config --libs libusb-1.0)

build/%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

cp210x-cfg: $(OBJS)
	$(CC) $^ $(LDFLAGS) -o $@


.PHONY: clean
clean:
	-rm -f build/* cp210x-cfg
