CC=turbo cc
LD=turbo cc
AR=/opt/wasi-sdk/bin/llvm-ar
RANLIB=/opt/wasi-sdk/bin/llvm-ranlib
LDFLAGS=-Wl,-shared -Wl,--no-entry -nostdlib -Wl,--export-all
CFLAGS=-fPIC

install/lib/libyaml.a:
	cd ./src && \
		./bootstrap && \
		AR=$(AR) CFLAGS=$(CFLAGS) RANLIB=$(RANLIB) LDFLAGS="$(LDFLAGS)" CC="$(CC)" LD="$(LD)" ./configure --host=wasm32 \
			--enable-shared --with-pic --prefix=$(PWD)/install --disable-dependency-tracking && \
		make && \
		make install

.PHONY: clean
clean:
	rm -rf ./install/
	find . -name "*.o" -delete
	find . -name "*.lo" -delete
