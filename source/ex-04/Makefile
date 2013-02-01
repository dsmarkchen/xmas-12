CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../../source/ex-04
BUILD_DIR=../../build
CPP_EX_04 = $(BUILD_DIR)/ex-04
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o
CPP_LIBS = -lpthread 


OBJS_CPP_EX_04 = $(BUILD_DIR)/ex-04.o 

$(BUILD_DIR)/ex-04.o: $(SRC_DIR)/ex-04.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CPP_EX_04)

pre_compile: $(SRC_DIR)/ex-04.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex ex-04.tex
	cp ex-04.c ex-04.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CPP_EX_04) : $(OBJS_CPP_EX_04) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CPP_EX_04)"        "$(OBJS_CPP_EX_04)
	$(LD) -o $(CPP_EX_04) $(OBJS_CPP_EX_04) $(GTEST_OBJS) $(CPP_LIBS)


clean:
	$(RM) $(OBJS_CPP_EX_04) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/ex-04.cpp  \
              $(SRC_DIR)/ex-04.pdf  \
              $(SRC_DIR)/ex-04.tex  \
              $(SRC_DIR)/ex-04.log \
              $(SRC_DIR)/ex-04.idx  \
              $(SRC_DIR)/ex-04.scn  \
              $(SRC_DIR)/ex-04.toc  \
              $(SRC_DIR)/ex-04.c


