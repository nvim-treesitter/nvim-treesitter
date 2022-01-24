#
# compile_parsers.makefile
#

CFLAGS       ?= -std=c99 -fPIC
CXXFLAGS     ?= -std=c++14 -fPIC
LDFLAGS      ?= -Os -shared
SRC_DIR      ?= ./src
DEST_DIR     ?= ./dest

ifeq ($(OS),Windows_NT)
   MKDIR  ?= mkdir
   RM     ?= cmd /C rmdir /Q /S
   CP     ?= copy
   TARGET ?= parser.dll
else
   MKDIR  ?= mkdir -p
   RM     ?= rm -rf
   CP     ?= cp
   TARGET ?= parser.so
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
	$(RM) $(OBJECTS) $(TARGET)

install: $(TARGET)
	$(MKDIR) $(DEST_DIR)
	$(CP) $^ $(DEST_DIR)

uninstall:
	$(RM) $(DEST_DIR)/$(TARGET)

.PHONY: clean uninstall
