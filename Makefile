# Makefile for gcc compiler for toolchain 4 (SDK Headers)

PROJECTNAME:=MPPlayer
APPFOLDER:=$(PROJECTNAME).app
INSTALLFOLDERi:=$(PROJECTNAME).app

TOOLCHAIN:=~/toolchain4
SDK:=$(TOOLCHAIN)/sys
MINIMUMVERSION:=4.0
DEPLOYMENTTARGET:=$(MINIMUMVERSION)
IPHONEOSMINVERSION:=40000
#define __IPHONE_3_0     30000
#define __IPHONE_4_0     40000
#define __IPHONE_3_0     30000
#define __IPHONE_4_0     40000
#define __IPHONE_4_1     40100
#define __IPHONE_4_2     40200
DEBUG=DEBUGOFF

#CC:=$(TOOLCHAIN)/pre/bin/arm-apple-darwin9-gcc
CC:=clang -ccc-host-triple arm-apple-darwin9 
CPP:=$(TOOLCHAIN)/pre/bin/arm-apple-darwin9-g++
LD:=$(TOOLCHAIN)/pre/bin/arm-apple-darwin9-gcc


LDFLAGS := -lobjc -Obj-C
LDFLAGS += -framework CoreFoundation 
LDFLAGS += -framework Foundation 
LDFLAGS += -framework UIKit 
LDFLAGS += -framework CoreGraphics
//LDFLAGS += -framework AVFoundation
//LDFLAGS += -framework AddressBook
//LDFLAGS += -framework AddressBookUI
//LDFLAGS += -framework AudioToolbox
//LDFLAGS += -framework AudioUnit
//LDFLAGS += -framework CFNetwork
//LDFLAGS += -framework CoreAudio
//LDFLAGS += -framework CoreData
//LDFLAGS += -framework CoreFoundation 
//LDFLAGS += -framework GraphicsServices
//LDFLAGS += -framework CoreLocation
//LDFLAGS += -framework ExternalAccessory
//LDFLAGS += -framework GameKit
//LDFLAGS += -framework IOKit
//LDFLAGS += -framework MapKit
LDFLAGS += -framework MediaPlayer
//LDFLAGS += -framework MessageUI
//LDFLAGS += -framework MobileCoreServices
//LDFLAGS += -framework OpenAL
//LDFLAGS += -framework OpenGLES
//LDFLAGS += -framework QuartzCore
//LDFLAGS += -framework Security
//LDFLAGS += -framework StoreKit
//LDFLAGS += -framework System
//LDFLAGS += -framework SystemConfiguration
//LDFLAGS += -framework CoreSurface
//LDFLAGS += -framework GraphicsServices
//LDFLAGS += -framework Celestial
//LDFLAGS += -framework WebCore
//LDFLAGS += -framework WebKit
//LDFLAGS += -framework SpringBoardUI
//LDFLAGS += -framework TelephonyUI
//LDFLAGS += -framework JavaScriptCore
//LDFLAGS += -framework PhotoLibrary

LDFLAGS += -isysroot $(SDK)
//LDFLAGS += -F"$(SDK)/System/Library/Frameworks"
LDFLAGS += -F"$(SDK)/System/Library/PrivateFrameworks"
LDFLAGS += -Wl,-dead_strip -all_load -miphoneos-version-min=$(MINIMUMVERSION)
LDFLAGS += -bind_at_load
LDFLAGS += -multiply_defined suppress
LDFLAGS += -arch=armv6
//LDFLAGS += -march=armv6
//LDFLAGS += -mcpu=arm1176jzf-s 

CFLAGS += -ObjC -fblocks
CFLAGS += -std=c99 #-Wall 
CFLAGS += -isysroot $(SDK)
CFLAGS += -D__IPHONE_OS_VERSION_MIN_REQUIRED=$(IPHONEOSMINVERSION)
ifeq ($(DEBUG),DEBUGOFF)
CFLAGS += -g0 -O2
else
CFLAGS += -g
CFLAGS += -D$(DEBUG)
endif
CFLAGS += -Wno-attributes -Wno-trigraphs -Wreturn-type -Wunused-variable

ifeq ($(DEBUG),DEBUGOFF)
CPPFLAGS += -g0 -O2
else
CPPFLAGS += -g
CPPFLAGS += -D$(DEBUG)
endif
CPPFLAGS += -isysroot $(SDK)
CPPFLAGS += -D__IPHONE_OS_VERSION_MIN_REQUIRED=$(IPHONEOSMINVERSION)
CPPFLAGS += -Wno-attributes -Wno-trigraphs -Wreturn-type -Wunused-variable
CPPFLAGS += -I"$(SDK)/usr/include/c++/4.2.1" 
CPPFLAGS += -I"$(SDK)/usr/include/c++/4.2.1/armv7-apple-darwin9" 

BUILDDIR=./build/$(MINIMUMVERSION)
SRCDIR1=.
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR1)/*.m))
OBJS+=$(patsubst %.c,%.o,$(wildcard $(SRCDIR1)/*.c))
RESOURCES+=$(wildcard ./images/*)
RESOURCES+=$(wildcard ./*.png)
RESOURCES+=$(wildcard ./*.mp4)
RESOURCES+=$(wildcard ./*.lproj)
PCH:=$(wildcard *.pch)
INFOPLIST:=$(wildcard *Info.plist)

CFLAGS += -I"$(SRCDIR1)"
CPPLAGS += -I"$(SRCDIR1)"

all:	$(PROJECTNAME)

$(PROJECTNAME):	$(OBJS)
	export IPHONEOS_DEPLOYMENT_TARGET=$(DEPLOYMENTTARGET);$(LD) $(LDFLAGS) $(filter %.o,$^) -o $@ 

%.o:	%.m
	$(CC) -include $(PCH) -c $(CFLAGS) $< -o $@

%.o:	%.c
	$(CC) -include $(PCH) -c $(CFLAGS) $< -o $@

%.o:	%.cpp
	$(CPP) -include $(PCH) -c $(CPPFLAGS) $< -o $@

dist:	$(PROJECTNAME)
	rm -rf $(BUILDDIR)
	mkdir -p $(BUILDDIR)/$(APPFOLDER)
ifneq ($(RESOURCES),)
	cp -r $(RESOURCES) $(BUILDDIR)/$(APPFOLDER)
	rm -fr $(BUILDDIR)/$(APPFOLDER)/.svn
	rm -fr $(BUILDDIR)/$(APPFOLDER)/*/.svn
endif
	cp $(INFOPLIST) $(BUILDDIR)/$(APPFOLDER)/Info.plist
	@echo "APPL????" > $(BUILDDIR)/$(APPFOLDER)/PkgInfo
	export CODESIGN_ALLOCATE=$(TOOLCHAIN)/pre/bin/arm-apple-darwin9-codesign_allocate; $(TOOLCHAIN)/pre/bin/ldid -S $(PROJECTNAME)
	mv $(PROJECTNAME) $(BUILDDIR)/$(APPFOLDER)
	mkdir -p $(BUILDDIR)/Payload
	cd $(BUILDDIR)/Payload; ln -s ../$(APPFOLDER) .; ln -s ../$(APPFOLDER)/iTunesArtwork iTunesArtwork
	cd $(BUILDDIR); zip -r $(PROJECTNAME).ipa Payload > /dev/null
	rm -fr $(BUILDDIR)/Payload

install: dist
	ping -t 3 -c 1 $(IPHONE_IP)
	ssh root@$(IPHONE_IP) 'rm -fr /Applications/$(INSTALLFOLDER)'
	scp -r $(BUILDDIR)/$(APPFOLDER) root@$(IPHONE_IP):/Applications/$(INSTALLFOLDER)
	@echo "Application $(INSTALLFOLDER) installed"
	ssh mobile@$(IPHONE_IP) 'uicache'

uninstall:
	ping -t 3 -c 1 $(IPHONE_IP)
	ssh root@$(IPHONE_IP) 'rm -fr /Applications/$(INSTALLFOLDER)'
	@echo "Application $(INSTALLFOLDER) uninstalled"

clean:
	@rm -f $(SRCDIR1)/*.o
	@rm -rf $(BUILDDIR)
	@rm -f $(PROJECTNAME)

.PHONY: all dist install uninstall clean
