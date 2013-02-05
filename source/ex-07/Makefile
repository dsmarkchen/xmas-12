CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../../source/ex-07
BUILD_DIR=../../build
CPP_EX_06 = $(BUILD_DIR)/ex-07
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o
CPP_LIBS = -lpthread 


OBJS_CPP_EX_06 = $(BUILD_DIR)/ex-07.o 

$(BUILD_DIR)/ex-07.o: $(SRC_DIR)/ex-07.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CPP_EX_06)

pre_compile: $(SRC_DIR)/ex-07.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex ex-07.tex
	cp ex-07.c ex-07.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CPP_EX_06) : $(OBJS_CPP_EX_06) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CPP_EX_06)"        "$(OBJS_CPP_EX_06)
	$(LD) -o $(CPP_EX_06) $(OBJS_CPP_EX_06) $(GTEST_OBJS) $(CPP_LIBS) -lstdc++


clean:
	$(RM) $(OBJS_CPP_EX_06) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/ex-07.cpp  \
              $(SRC_DIR)/ex-07.pdf  \
              $(SRC_DIR)/ex-07.tex  \
              $(SRC_DIR)/ex-07.log \
              $(SRC_DIR)/ex-07.idx  \
              $(SRC_DIR)/ex-07.scn  \
              $(SRC_DIR)/ex-07.toc  \
              $(SRC_DIR)/ex-07.c


