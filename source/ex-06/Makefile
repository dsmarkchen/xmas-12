CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../../source/ex-06
BUILD_DIR=../../build
CPP_EX_06 = $(BUILD_DIR)/ex-06
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o
CPP_LIBS = -lpthread 


OBJS_CPP_EX_06 = $(BUILD_DIR)/ex-06.o 

$(BUILD_DIR)/ex-06.o: $(SRC_DIR)/ex-06.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CPP_EX_06)

pre_compile: $(SRC_DIR)/ex-06.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex ex-06.tex
	cp ex-06.c ex-06.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CPP_EX_06) : $(OBJS_CPP_EX_06) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CPP_EX_06)"        "$(OBJS_CPP_EX_06)
	$(LD) -o $(CPP_EX_06) $(OBJS_CPP_EX_06) $(GTEST_OBJS) $(CPP_LIBS)


clean:
	$(RM) $(OBJS_CPP_EX_06) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/ex-06.cpp  \
              $(SRC_DIR)/ex-06.pdf  \
              $(SRC_DIR)/ex-06.tex  \
              $(SRC_DIR)/ex-06.log \
              $(SRC_DIR)/ex-06.idx  \
              $(SRC_DIR)/ex-06.scn  \
              $(SRC_DIR)/ex-06.toc  \
              $(SRC_DIR)/ex-06.c


