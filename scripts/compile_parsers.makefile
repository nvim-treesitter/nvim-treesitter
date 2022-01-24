#
# compile_parsers.makefile
#

CFLAGS       ?= -std=c99 -fPIC
CXXFLAGS     ?= -std=c++14 -fPIC
LDFLAGS      ?= -Os -shared
SRC_DIR      ?= ./src
DEST_DIR     ?= ./dest

ifeq ($(OS),Windows_NT)
   SHELL       := powershell.exe
   .SHELLFLAGS := -NoProfile
   RM          := Remove-Item -Force
   CP          := Copy-Item -Recurse
   MKDIR       := New-Item -ItemType directory
   TARGET      := parser.dll
else
   RM          := rm -rf
   CP          := cp
   TARGET      := parser.so
endif

ifneq ($(wildcard src/*.cc),)
   LDFLAGS += -lstdc++
endif

OBJECTS   := parser.o scanner.o

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(TARGET) $(LDFLAGS)

%.o: src/%.c
	$(CC) -c $(CFLAGS) -I$(SRC_DIR) -o $@ $<

%.o: src/%.cc
	$(CC) -c $(CXXFLAGS) -I$(SRC_DIR) -o $@ $<

clean:
	$(foreach file, $(OBJECTS), $(RM) $(file))
	$(RM) $(TARGET)

$(DEST_DIR):
	test -d $(DEST_DIR) || $(MKDIR) $(DEST_DIR)

install: $(TARGET) $(DEST_DIR)
	$(CP) $^ $(DEST_DIR)

.PHONY: clean
