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
   .SHELLFLAGS := -NoProfile -command
   CP          := Copy-Item -Recurse -ErrorAction SilentlyContinue
   MKDIR       := New-Item -ItemType directory -ErrorAction SilentlyContinue
   TARGET      := parser.dll
   rmf         = Write-Output $(1) | foreach { if (Test-Path $$_) { Remove-Item -Force } }
else
   CP          := cp
   MKDIR       := mkdir -p
   TARGET      := parser.so
   rmf         = rm -rf $(1)
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
	$(call rmf,$(TARGET) $(OBJECTS))

$(DEST_DIR):
	@$(MKDIR) $(DEST_DIR)

install: $(TARGET) $(DEST_DIR)
	$(CP) $(TARGET) $(DEST_DIR)/

.PHONY: clean
