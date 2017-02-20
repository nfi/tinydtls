# Makefile for tinydtls
#
#
# Copyright (c) 2011, 2012, 2013, 2014, 2015, 2016 Olaf Bergmann (TZI) and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# and Eclipse Distribution License v. 1.0 which accompanies this distribution.
#
# The Eclipse Public License is available at http://www.eclipse.org/legal/epl-v10.html
# and the Eclipse Distribution License is available at
# http://www.eclipse.org/org/documents/edl-v10.php.
#
# Contributors:
#    Olaf Bergmann  - initial API and implementation
#

# the library's version
VERSION:=0.8.6

# should probably be from the autoconf system.
ifeq ($(DTLS_SUPPORT), )
 DTLS_SUPPORT=posix
endif

# files and flags
SOURCES = dtls.c crypto.c ccm.c hmac.c netq.c peer.c dtls_debug.c
SOURCES+= aes/rijndael.c ecc/ecc.c sha2/sha2.c $(DTLS_SUPPORT)/dtls-support.c
DTLS_DIRS:= aes ecc sta2 $(DTLS_SUPPORT)
OBJECTS:= $(SOURCES:.c=.o)
CFLAGS:=-Wall -std=c99 -g -O2 -I. ${addprefix -I,$(DTLS_DIRS)}
CPPFLAGS:= -DDTLSv12 -DWITH_SHA256 -DDTLS_CHECK_CONTENTTYPE
LIB:=libtinydtls.a
LDFLAGS:=
ARFLAGS:=cru
doc:=doc

.PHONY: all clean doc

.SUFFIXES:
.SUFFIXES:      .c .o

all:	$(LIB)

check:
	$(MAKE) -C tests check

$(LIB):	$(OBJECTS)
	$(AR) $(ARFLAGS) $@ $^
	ranlib $@

clean:
	@rm -f $(LIB) $(OBJECTS)

doc:
	$(MAKE) -C doc