CC=clang
SWIFTC=swiftc

ifeq ($(shell uname -s), Darwin)
XCODE=$(shell xcode-select -p)
SDK=$(XCODE)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk
TARGET=x86_64-apple-macosx10.10

CC=clang -target $(TARGET)
SWIFTC=swiftc -target $(TARGET) -sdk $(SDK) -Xlinker -all_load
endif

.PHONY: all clean lib

ALCATRAZ=Externals/Alcatraz/Alcatraz
BUILD_DIR=.build/debug

ALL_SRCS=$(wildcard $(ALCATRAZ)/Packages/*.m)
ALL_SRCS+=$(ALCATRAZ)/Categories/NSFileManager+Alcatraz.m
ALL_SRCS+=$(wildcard $(ALCATRAZ)/Helpers/*.m)
ALL_SRCS+=$(wildcard $(ALCATRAZ)/Installers/*.m)
SRCS=$(filter-out $(ALCATRAZ)/Helpers/ATZStyleKit.m,$(ALL_SRCS))

CFLAGS=-I$(ALCATRAZ)/Categories -I$(ALCATRAZ)/Helpers -I$(ALCATRAZ)/Installers -I$(ALCATRAZ)/Packages

LIBS=$(wildcard $(BUILD_DIR)/*.a)
LDFLAGS=$(foreach lib,$(LIBS),-Xlinker $(lib))
OBJS=$(patsubst %.m,%.o,$(SRCS))

all: $(BUILD_DIR)/azkaban
	./$<

$(BUILD_DIR)/azkaban: Sources/main.swift $(BUILD_DIR)/libAlcatraz.a lib
	$(SWIFTC) -o $@ $< -Xlinker $(BUILD_DIR)/libAlcatraz.a -I$(BUILD_DIR) $(LDFLAGS)

$(BUILD_DIR)/libAlcatraz.a: $(OBJS)
	libtool -o $@ $^

lib:
	swift build

clean:
	swift build --clean
	rm -f $(BUILD_DIR)/libAlcatraz.a $(BUILD_DIR)/azkaban $(OBJS)
