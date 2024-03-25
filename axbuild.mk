nginx-version = 1.24.0
nginx-src := $(APP)/nginx-$(nginx-version)
nginx-objdir := $(APP)/objs
nginx-objs := objs/openssl-1.1.1w/libcrypto.a objs/openssl-1.1.1w/libssl.a objs/nginx_app.o 

app-objs := $(nginx-objs)

CFLAGS += -Wno-format

nginx-build-args := \
  CC=$(CC) \
  CFLAGS="$(CFLAGS)" \
  ARCH=$(ARCH) \
  USE_JEMALLOC=no \
  -j

ifneq ($(V),)
  nginx-build-args += V=$(V)
endif

ifeq ($(V9P),y)
  DISK_ARG = 9p
else
  DISK_ARG = no_9p
endif


disk.img:
	echo "nginx makefile create_nginx_img"
	./$(APP)/create_nginx_img.sh $(DISK_ARG)

$(APP)/$(nginx-objs): build_nginx

clean_c::
	find . -type f \( -name "*.o" -o -name "*.elf" -o -name "*.bin" \) -exec rm -f {} +

build_nginx: disk.img $(nginx-objdir)
	echo "$(nginx-build-args)"
	cd $(nginx-objdir) && $(MAKE) $(nginx-build-args)


.PHONY: build_nginx
