SHELL = /bin/sh
CC= gcc
AR = ar rc
CFLAGS = -O3 -pipe -fPIC -D_GNU_SOURCE -m64  -I/usr/local/Eiffel_15.01/studio/spec/linux-x86-64/include -I$(MYSQLINC)
LDFLAGS = -m elf_x86_64
LIBS = -lm
MAKE = make
MKDEP = \$(EIFFEL_SRC)/C/mkdep $(DPFLAGS) --
MV = /bin/mv
RANLIB = :
RM = /bin/rm -f
PLATFORM = linux-x86-64

.c.o:
	$(CC) $(CFLAGS) -c $<

OBJECTS = eif_mysql.o

libmysql_store.a: $(OBJECTS)
	mkdir -p ../../../../spec/$(PLATFORM)/lib
	$(RM) $@
	$(AR) $@ $(OBJECTS)
	$(MV) $@ ../../../../spec/$(PLATFORM)/lib
	$(RANLIB) ../../../../spec/$(PLATFORM)/lib/$@
	$(MAKE) clean

	#$(RM) libmysql_store.a $(OBJECTS) Makefile config.sh
clean:
	$(RM) libmysql_store.a $(OBJECTS)
