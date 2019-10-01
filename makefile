ifdef
                                    88888888
                                  888888888888
                                 88888888888888
                                8888888888888888
                               888888888888888888
                              888888  8888  888888
                              88888    88    88888
                              888888  8888  888888
                              88888888888888888888
                              88888888888888888888
                             8888888888888888888888
                          8888888888888888888888888888
                        88888888888888888888888888888888
                              88888888888888888888
                            888888888888888888888888
                           888888  8888888888  888888
                           888     8888  8888     888
                                   888    888

                                   OCTOBANANA

Licensed under the MIT License

Copyright (c) 2019 Brett Robinson <https://octobanana.com/>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
endif

# Info
TARGET := hexana
BUILD_TYPE ?= release

# Programs
MKDIR := mkdir -p
CP := cp
RM := rm -rf
LD := ld.lld
AS := nasm

# Assembly
ASFLAGS += -f elf64

# C
C_BEGIN := /usr/lib/musl/lib/crt1.o /usr/lib/musl/lib/crti.o
C_END := /usr/lib/musl/lib/crtn.o

# Linker
LDFLAGS += -m elf_x86_64 -dynamic-linker /lib/ld-musl-x86_64.so.1 -nostdlib -static -L /usr/lib/musl/lib
LDLIBS += -lc

# Build Type
ifeq ($(BUILD_TYPE), release)
# Release
ASFLAGS += -Ox
else
# Debug
ASFLAGS += -g -F dwarf -O0
BUILD_TYPE = debug
endif

# Directories
PREFIX ?= /usr/local
RAW_DIR := src
BASE_DIR := build
BUILD_DIR := $(BASE_DIR)/$(BUILD_TYPE)
SRC_DIR := $(BUILD_DIR)/src
OBJ_DIR := $(BUILD_DIR)/obj

# Files
BIN_TARGET := $(BUILD_DIR)/$(TARGET)
SRC_FILES := $(patsubst $(RAW_DIR)/%, $(SRC_DIR)/%, $(wildcard $(RAW_DIR)/*))
OBJ_FILES := $(patsubst $(RAW_DIR)/%.asm, $(OBJ_DIR)/%.o, $(wildcard $(RAW_DIR)/*.asm))

.SILENT:
.NOTPARALLEL:
.PRECIOUS: $(SRC_FILES)

all: $(BIN_TARGET)
.PHONY: all

$(BIN_TARGET): $(SRC_FILES) $(OBJ_FILES)
	$(info Linking[$(BUILD_TYPE)]: $(TARGET))
	$(LD) -o $@ $(LDFLAGS) $(C_BEGIN) $(OBJ_FILES) $(LDLIBS) $(C_END)

$(OBJ_FILES): $(SRC_FILES)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	$(info Building[$(BUILD_TYPE)]: $< -> $@)
	$(MKDIR) $(@D)
	$(AS) $(ASFLAGS) $< -o $@

$(SRC_DIR)/%: $(RAW_DIR)/%
	$(info Processing[$(BUILD_TYPE)]: $< -> $@)
	$(MKDIR) $(@D)
	$(CP) $< $@

build: all
.PHONY: build

rebuild: clean all
.PHONY: rebuild

clean:
	$(info Cleaning: $(TARGET))
	$(RM) $(BASE_DIR)
.PHONY: clean

install:
	$(info Installing[$(BUILD_TYPE)]: $(TARGET) -> $(PREFIX)/bin/$(TARGET))
	install -m 755 $(BIN_TARGET) $(PREFIX)/bin/$(TARGET)
.PHONY: install

run: all
	./$(BIN_TARGET)
.PHONY: run

debug: all
	gdb -x ./.gdb -q $(BIN_TARGET)
.PHONY: debug

print\:%: ; $(info $* = $($*)) true
.PHONY: print\:%
