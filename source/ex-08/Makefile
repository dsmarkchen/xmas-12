CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../../source/ex-08
BUILD_DIR=../../build
CPP_EX_08 = $(BUILD_DIR)/ex-08
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o
CPP_LIBS = -lpthread 


OBJS_CPP_EX_08 = $(BUILD_DIR)/ex-08.o 

$(BUILD_DIR)/ex-08.o: $(SRC_DIR)/ex-08.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CPP_EX_08)

pre_compile: $(SRC_DIR)/ex-08.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex ex-08.tex
	cp ex-08.c ex-08.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CPP_EX_08) : $(OBJS_CPP_EX_08) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CPP_EX_08)"        "$(OBJS_CPP_EX_08)
	$(LD) -o $(CPP_EX_08) $(OBJS_CPP_EX_08) $(GTEST_OBJS) $(CPP_LIBS)


clean:
	$(RM) $(OBJS_CPP_EX_08) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/ex-08.cpp  \
              $(SRC_DIR)/ex-08.pdf  \
              $(SRC_DIR)/ex-08.tex  \
              $(SRC_DIR)/ex-08.log \
              $(SRC_DIR)/ex-08.idx  \
              $(SRC_DIR)/ex-08.scn  \
              $(SRC_DIR)/ex-08.toc  \
              $(SRC_DIR)/ex-08.c


