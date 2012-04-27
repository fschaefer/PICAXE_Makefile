
PICAXE_COMPILER = picaxe20m2
PICAXE_PORT = /dev/tty.usbserial-00001004
#PICAXE_PORT = /dev/tty.usbserial

SRC = PICAXE_pov.bas


PICAXE_DEBUG = -d
PICAXE_DEBUG_EXT = -e
PICAXE_DEBUG_EXT_HEX = -eh
PICAXE_DEBUG_HEX = -dh
PICAXE_SERTXD = -t
PICAXE_SERTXD_HEX = -th
PICAXE_SERTXD_INT = -ti

MSG_BEGIN = -------- begin --------
MSG_CLEANING = Cleaning project:
MSG_END = --------  end  --------
MSG_ERRORS_NONE = Errors: none

REMOVE = rm -f

TARGET = $(basename $(SRC)).bas
ERROR = $(basename $(TARGET)).err

all: __begin __download __finished __end

check: __begin __syntax __finished __end

clean: __begin __clean __finished __end

debug: __begin __debug __end

debug_ext: __begin __debug_ext __end

debug_ext_hex: __begin __debug_ext_hex __end

debug_hex: __begin __debug_hex __end

sertxd: __begin __sertxd __end

sertxd_hex: __begin __sertxd_hex __end

sertxd_int: __begin __sertxd_int __end

__begin:
	@echo
	@echo $(MSG_BEGIN)

__clean:
	@echo
	@echo $(MSG_CLEANING)
	$(REMOVE) $(ERROR)

__debug: $(TARGET)
	$(PICAXE_COMPILER) $(PICAXE_DEBUG) -c$(PICAXE_PORT) $(TARGET)

__debug_ext: $(TARGET)
	$(PICAXE_COMPILER) $(PICAXE_DEBUG_EXT) -c$(PICAXE_PORT) $(TARGET)

__debug_ext_hex: $(TARGET)
	$(PICAXE_COMPILER) $(PICAXE_DEBUG_EXT_HEX) -c$(PICAXE_PORT) $(TARGET)

__debug_hex: $(TARGET)
	$(PICAXE_COMPILER) $(PICAXE_DEBUG_HEX) -c$(PICAXE_PORT) $(TARGET)

__download: $(TARGET)
	$(PICAXE_COMPILER) -c$(PICAXE_PORT) $(TARGET)

__end:
	@echo $(MSG_END)
	@echo

__finished:
	@echo $(MSG_ERRORS_NONE)
			
__sertxd: $(TARGET)
	$(PICAXE_COMPILER) $(PICAXE_SERTXD) -c$(PICAXE_PORT) $(TARGET)

__sertxd_hex: $(TARGET)
	$(PICAXE_COMPILER) $(PICAXE_SERTXD_HEX) -c$(PICAXE_PORT) $(TARGET)

__sertxd_int: $(TARGET)
	$(PICAXE_COMPILER) $(PICAXE_SERTXD_INT) -c$(PICAXE_PORT) $(TARGET)

__syntax: $(TARGET)
	$(PICAXE_COMPILER) -s $(TARGET)

.PHONY: all check clean debug debug_ext debug_ext_hex debug_hex sertxd \
        sertx_hex sertxd_int __begin __clean __debug __debug_ext       \
        __debug_ext_hex __debug_hex __download __end __finished        \
        __sertxd __sertxd_hex __sertxd_int __syntax
