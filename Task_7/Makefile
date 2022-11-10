# Detect OS/platform:
include makefile_os.inc

CXX = gcc
FASM = ./fasmg.x64

TARGETS = call_from_c call_from_a
BIN_DIR = bin

# If OS is not Linux raise error:
ifneq ($(USED_OS), LINUX)
$(error "This makefile is for Linux only. Current OS is $(USED_OS)")
endif

all: ${BIN_DIR} ${TARGETS}
	echo "Build targets: ${TARGETS}"

${BIN_DIR}:
	mkdir -p ${BIN_DIR}

call_from_c: call_from_c.o solve.o
	${CXX} $^ -o ${BIN_DIR}/$@

call_from_a: call_from_a.o solve.o
	${CXX} $^ -o ${BIN_DIR}/$@ -no-pie

.INTERMEDIATE: call_from_c.o call_from_a.o solve.o

%.o: %.c
	${CXX} $^ -o $@ -c

%.o: %.asm
	INCLUDE=${CURDIR}/../x86/include ${FASM} $<

.PHONY: clean
clean:
	rm -rf *.o ${BIN_DIR} || true
