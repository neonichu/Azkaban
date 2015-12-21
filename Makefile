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

HEADER_SEARCH_PATHS=-I$(ALCATRAZ)/Categories -I$(ALCATRAZ)/Helpers
HEADER_SEARCH_PATHS+=-I$(ALCATRAZ)/Installers -I$(ALCATRAZ)/Packages

HEADERS=$(patsubst %.m,%.h,$(SRCS))
LIBS=$(wildcard $(BUILD_DIR)/*.a)
MAIN_SRCS=$(wildcard Sources/*.swift)
OBJS=$(patsubst %.m,%.o,$(SRCS))

CFLAGS=-fobjc-arc -g3 $(HEADER_SEARCH_PATHS)
LDFLAGS=$(foreach lib,$(LIBS),-Xlinker $(lib))

all: $(BUILD_DIR)/azkaban
	./$< list

Sources/BridgingHeader.h: $(HEADERS)
	`echo $(HEADERS)|sed -e 's/ /"§#import "/g' -e 's/^/#import "/' -e 's/$$/"/'|tr '§' '\n' >$@`

$(BUILD_DIR)/azkaban: $(MAIN_SRCS) $(BUILD_DIR)/libAlcatraz.a lib Sources/BridgingHeader.h
	$(SWIFTC) -o $@ $(MAIN_SRCS) -Xlinker $(BUILD_DIR)/libAlcatraz.a -I$(BUILD_DIR) $(LDFLAGS) \
		-import-objc-header Sources/BridgingHeader.h -I. $(HEADER_SEARCH_PATHS)

$(BUILD_DIR)/libAlcatraz.a: $(OBJS)
	@mkdir -p $(BUILD_DIR)
	libtool -o $@ $^

lib:
	swift build

clean:
	swift build --clean
	rm -f $(BUILD_DIR)/libAlcatraz.a $(BUILD_DIR)/azkaban $(OBJS)
